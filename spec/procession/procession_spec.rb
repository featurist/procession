require_relative '../../lib/procession/process'

module Procession

  describe Process do

    def example_app_path
      File.join(File.dirname(__FILE__), "example_app.rb")
    end

    it 'runs a process and awaits some output' do
      process = Process.new(command: "ruby #{example_app_path}", await: /#{Dir.pwd}/).start
      process.should be_alive
      process.stop
    end

    it 'sets environment variables' do
      process = Process.new(command: "ruby #{example_app_path}", environment: { FOO: 'omg' }, await: /omg/).start
      process.should be_alive
      process.stop
    end

    it 'accepts a working directory' do
      dir = File.dirname(__FILE__)
      Dir.chdir dir do
        process = Process.new(command: "ruby #{example_app_path}", await: /#{dir}/).start
        process.should be_alive
        process.stop
      end
    end

    describe 'when the process exits' do
      it 'raises an exception with the stdout output' do
        expect(lambda {
          Process.new(command: 'pwd').start
        }).to raise_error("The app process exited\nSTDOUT:\n#{Dir.pwd}\n")
      end
    end

  end

end
