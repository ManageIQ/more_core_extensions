require 'time'

RSpec.describe Time do
  let(:wtime) { 131_172_192_730_000_000 }
  let(:time) { Time.parse("2016-09-01 16:01:13 UTC").utc }

  context '.wtime_to_time' do
    it "returns the expected time" do
      expect(Time.wtime_to_time(wtime).to_s).to eq("2016-09-01 16:01:13 UTC")
      expect(Time.wtime_to_time(0).to_s).to eq("1601-01-01 00:00:00 UTC")
    end

    it "handles very large values" do
      expect(Time.wtime_to_time(9**40).to_s).to eq("468387534430910575002897-09-25 22:10:38 UTC")
    end

    it "requires a single argument" do
      expect { Time.wtime_to_time }.to raise_error(ArgumentError)
    end
  end

  context '.time_to_wtime' do
    it "returns the expected time" do
      expect(Time.time_to_wtime(time)).to eq(wtime)
    end

    it "requires a single argument" do
      expect { Time.time_to_wtime }.to raise_error(ArgumentError)
    end
  end
end
