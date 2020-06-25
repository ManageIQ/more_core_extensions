RSpec.describe Process do
  def get_process_status(pid)
    `ps -p #{pid} -o stat=`[0]
  end

  context ".alive?" do
    it "returns true when expected" do
      expect(Process.alive?(Process.pid)).to eql(true)
    end

    it "returns false when expected" do
      expect(Process.alive?(999999)).to eql(false)
    end
  end

  context ".pause" do
    before do
      @pid = Process.spawn(Gem.ruby, "-esleep 3 while true")
    end

    it "can pause a running process" do
      expect(get_process_status(@pid)).not_to eq('T')
      expect(Process.pause(@pid)).to eql(1)
      expect(get_process_status(@pid)).to eq('T')
    end

    it "is a no-op if the process is already paused" do
      expect(Process.pause(@pid)).to eq(1)
      expect { Process.pause(@pid) }.not_to raise_error
      expect(Process.pause(@pid)).to eq(1)
    end

    it "returns nil if the process is not running" do
      expect(Process.pause(99999999)).to be_nil
    end

    after do
      Process.kill(9, @pid)
    end
  end

  context ".resume" do
    before do
      @pid = Process.spawn(Gem.ruby, "-esleep 3 while true")
      Process.pause(@pid)
    end

    it "can resume a paused process" do
      expect(get_process_status(@pid)).to eq('T')
      Process.resume(@pid)
      expect(get_process_status(@pid)).not_to eq('T')
    end

    it "is a no-op if the process is already running" do
      expect(Process.resume(@pid)).to eq(1)
      expect { Process.resume(@pid) }.not_to raise_error
      expect(Process.resume(@pid)).to eq(1)
    end

    it "returns nil if the process is not running" do
      expect(Process.resume(99999999)).to be_nil
    end

    after do
      Process.kill(9, @pid)
    end
  end
end
