require 'childprocess'

module Procession
  class Process
    def initialize(options)
      @command = options.delete(:command)
      @await = options.delete(:await)
      @working_dir = options.delete(:working_dir)
      @environment = options.delete(:environment)
      @inherit_output = options.delete(:inherit_output)
    end

    def start
      args = @command.split(' ')
      @proc = ChildProcess.build(*args)

      setup_cwd
      setup_environment

      r, w = IO.pipe

      @proc.io.stdout = @proc.io.stderr = w
      @proc.leader = true
      @proc.start
      w.close

      all_output = ""

      begin
        started = false
        until started
          partial = r.readpartial(8192)
          puts partial if @inherit_output
          all_output << partial
          if (all_output =~ @await)
            started = true
          end
        end
      rescue EOFError
        raise ProcessExitedError.new "The app process exited\nSTDOUT:\n#{all_output}"
      end

      Thread.new do
        while true
          partial = r.readpartial(8192)
          puts partial if @inherit_output
        end
      end

      at_exit do
        @proc.stop
      end

      @proc.io.inherit!

      @proc
    end

    private

    def setup_environment
      @environment.each { |key, value| @proc.environment[key] = value } unless @environment.nil?
    end

    def setup_cwd
      @proc.cwd = @working_dir unless @working_dir.nil?
    end
  end

  class ProcessExitedError < RuntimeError; end
end
