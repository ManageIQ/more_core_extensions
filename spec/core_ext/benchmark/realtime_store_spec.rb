require 'timecop'
require 'timeout'

describe Benchmark do
  after(:each) { Timecop.return }
  after(:each) do
    # Isolate other tests
    Benchmark.delete_current_realtime if Benchmark.in_realtime_block?
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
    begin
      Benchmark.realtime_store(timings, :test1) do
        Timecop.travel(500)
        raise Exception
      end
    rescue Exception
      expect(timings[:test1]).to be_within(0.5).of(500)
    end
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
        Timecop.travel(2.1)
        Benchmark.realtime_block(:test2) do
          Timecop.travel(5.1)
          raise Exception
        end
      end
    end.to raise_exception(Exception)

    expect(Benchmark.in_realtime_block?).to be_falsey
  end

  it '.realtime_block with an Exception caught in inner block' do
    result = timings = nil
    expect do
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
    end.to_not output.to_stderr

    expect(result).to eq("value")
    expect(timings[:test1]).to be_within(0.5).of(1000)
    expect(timings[:test2]).to be_within(0.5).of(500)
    expect(Benchmark.in_realtime_block?).to be_falsey
  end

  it "Timeout raising within .realtime_block" do
    expect(Benchmark.in_realtime_block?).to be_falsey

    # If something left over from previous tests gets GC'd during Timeout, its finalizer may
    # be interrupted.  For example, interrupted Temfile cleanup may get stuck forever!
    # This reduces chance of nasty interactions...
    GC.start

    20.times do |i|
      begin
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
        raise("Completed without Timeout!?  Tip: may result from unclosed Tempfile object.")
      rescue Timeout::Error => e
        where = e.backtrace.first(10).join("\n")
        expect(Benchmark.in_realtime_block?).to be_falsey,
                                                "failed on #{i}th Timeout, #{e.inspect} interrupted in:\n#{where}"
      end
    end
  end
end
