
module Paperclip
  class MediaTypeSpoofDetector
    private

    def type_from_file_command
      # -- original code removed --
      # begin
      #   Paperclip.run("file", "-b --mime-type :file", :file => @file.path)
      # rescue Cocaine::CommandLineError
      #   ""
      # end

      # -- new code follows --
      begin
         Paperclip.run("file", "-b --mime :file", :file => @file.path)
      rescue Cocaine::CommandLineError
        ""
      end
    end
  end
end
require "paperclip"  
Paperclip.options[:command_path] = 'C:/Program Files/ImageMagick-6.9.0-Q16'
Paperclip.options[:swallow_stderr] = false
require "paperclip/railtie"
Paperclip::Railtie.insert
