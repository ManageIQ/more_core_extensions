require 'timecop'
require 'timeout'

describe Benchmark do
  after { Timecop.return }
  after do
    # Isolate other tests
    Benchmark.delete_current_realtime
  end

  it '.realtime_store' do
    timings = {}
    result = Benchmark.realtime_store(timings, :test1) do
      Timecop.travel(500)
      Benchmark.realtime_store(timings, :test2) do
        Timecop.travel(500)
        Benchmark.realtime_store(timings, :test3) do
          Timecop.travel(500)
        end
      end
      "test"
    end

    expect(result).to eq("test")
    expect(timings[:test1]).to be_within(0.5).of(1500)
    expect(timings[:test2]).to be_within(0.5).of(1000)
    expect(timings[:test3]).to be_within(0.5).of(500)
  end

  it '.realtime_store with an Exception' do
    timings = {}
    expect do
      Benchmark.realtime_store(timings, :test1) do
        Timecop.travel(500)
        raise Exception
      end
    end.to raise_error(Exception)

    expect(timings[:test1]).to be_within(0.5).of(500)
  end

  it '.realtime_block' do
    result, timings = Benchmark.realtime_block(:test1) do
      Timecop.travel(500)
      Benchmark.realtime_block(:test2) do
        Timecop.travel(500)
        Benchmark.realtime_block(:test3) do
          Timecop.travel(500)
        end
      end
      "test"
    end

    expect(result).to eq("test")
    expect(timings[:test1]).to be_within(0.5).of(1500)
    expect(timings[:test2]).to be_within(0.5).of(1000)
    expect(timings[:test3]).to be_within(0.5).of(500)
  end

  it '.in_realtime_block?' do
    expect(Benchmark.in_realtime_block?).to be_falsey
    Benchmark.realtime_block(:test1) do
      expect(Benchmark.in_realtime_block?).to be_truthy
    end
    expect(Benchmark.in_realtime_block?).to be_falsey
  end

  it '.realtime_block with an Exception aborting outermost block' do
    expect do
      Benchmark.realtime_block(:test1) do
        Timecop.travel(500)
        Benchmark.realtime_block(:test2) do
          Timecop.travel(500)
          raise Exception
        end
      end
    end.to raise_exception(Exception) do |err|
      expect(err.timings[:test1]).to be_within(0.1).of(1000)
      expect(err.timings[:test2]).to be_within(0.1).of(500)
    end

    expect(Benchmark.in_realtime_block?).to be_falsey
  end

  it '.realtime_block with an Exception caught in inner block' do
    result, timings = Benchmark.realtime_block(:test1) do
      begin
        Timecop.travel(500)
        Benchmark.realtime_block(:test2) do
          Timecop.travel(500)
          raise Exception
        end
      rescue Exception
        "value"
      end
    end

    expect(result).to eq("value")
    expect(timings[:test1]).to be_within(0.5).of(1000)
    expect(timings[:test2]).to be_within(0.5).of(500)
    expect(Benchmark.in_realtime_block?).to be_falsey
  end

  it ".realtime_block with a Timeout::Error raised within" do
    # If something left over from previous tests gets GC'd during Timeout, its finalizer may
    # be interrupted.  For example, interrupted Tempfile cleanup may get stuck forever!
    # This reduces chance of nasty interactions...
    expect(Benchmark.in_realtime_block?).to be_falsey
    GC.start

    20.times do |i|
      expect do
        # keep entering/exiting, abort ASAP
        Timeout.timeout(1e-9) do
          2_000_000.times do
            Benchmark.realtime_block(:test1) do
              Benchmark.realtime_block(:test2) do
              end
              "result"
            end
          end
        end
        raise "Completed without Timeout!?  Tip: may result from unclosed Tempfile object."
      end.to raise_error(Timeout::Error) do |e|
        expect(Benchmark.in_realtime_block?).to be_falsey, "failed on round #{i}, #{e.inspect} interrupted in:\n#{e.backtrace.join("\n")}"
      end
    end
  end
end
