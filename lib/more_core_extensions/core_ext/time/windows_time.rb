module MoreCoreExtensions
  module WindowsTime
    # Convert 64-bit FILETIME integer into Time object.
    def wtime2time(wtime)
      Time.at((wtime - 116444736000000000) / 10000000)
    end
  end
end

Time.extend(MoreCoreExtensions::WindowsTime)
