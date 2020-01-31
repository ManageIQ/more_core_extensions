module MoreCoreExtensions
  module ProcessPauseResume
    if Gem.win_platform?
      require 'fiddle'
      ntdll = Fiddle.dlopen('ntdll')
      kernel32 = Fiddle.dlopen('kernel32')

      NtSuspendProcess = Fiddle::Function.new(
        ntdll['NtSuspendProcess'],
        [Fiddle::TYPE_UINTPTR_T],
        Fiddle::TYPE_INT
      )

      private_constant :NtSuspendProcess

      NtResumeProcess = Fiddle::Function.new(
        ntdll['NtResumeProcess'],
        [Fiddle::TYPE_UINTPTR_T],
        Fiddle::TYPE_INT
      )

      private_constant :NtResumeProcess

      OpenProcess = Fiddle::Function.new(
        kernel32['OpenProcess'],
        [Fiddle::TYPE_LONG, Fiddle::TYPE_INT, Fiddle::TYPE_LONG],
        Fiddle::TYPE_UINTPTR_T
      )

      private_constant :OpenProcess

      CloseHandle = Fiddle::Function.new(
        kernel32['CloseHandle'],
        [Fiddle::TYPE_UINTPTR_T],
        Fiddle::TYPE_INT
      )

      private_constant :CloseHandle

      PROCESS_SUSPEND_RESUME = 0x00000800

      private_constant :PROCESS_SUSPEND_RESUME
    end

    # Returns whether or not the given process is running.
    #
    def alive?(pid)
      Process.kill(0, pid)
      true
    rescue Errno::ESRCH
      false
    end

    # Suspend the process +pid+. If the process isn't running then this is no-op.
    #
    if Gem.win_platform?
      def pause(pid)
        return unless alive?(pid)

        begin
          handle = OpenProcess.call(PROCESS_SUSPEND_RESUME, 0, pid)

          if handle == 0
            raise SystemCallError, Fiddle.win32_last_error, "OpenProcess"
          end

          if NtSuspendProcess.call(handle) != 0
            raise SystemCallError, Fiddle.win32_last_error, "NtSuspendProcess"
          end
        ensure
          CloseHandle.call(handle) if handle
        end
        1 # For cross-platform compatibility
      end
    else
      def pause(pid)
        Process.kill('STOP', pid) if alive?(pid)
      end
    end

    # Resume the process +pid+. If the process isn't running then this is a no-op.
    #
    if Gem.win_platform?
      def resume(pid)
        return unless alive?(pid)

        begin
          handle = OpenProcess.call(PROCESS_SUSPEND_RESUME, 0, pid)

          if handle == 0
            raise SystemCallError, Fiddle.win32_last_error, "OpenProcess"
          end

          if NtResumeProcess.call(handle) != 0
            raise SystemCallError, Fiddle.win32_last_error, "NtResumeProcess"
          end
        ensure
          CloseHandle.call(handle) if handle
        end
        1 # For cross-platform compatibility
      end
    else
      def resume(pid)
        Process.kill('CONT', pid) if alive?(pid)
      end
    end
  end
end

Process.send(:extend, MoreCoreExtensions::ProcessPauseResume)
