module RealWorldRails
  module Inspectors

    class ViewSpecsInspector < Inspector

      inspects :specs, %r{/views/}

      def inspect_file(filename)
        puts formatted_filename(filename)
        buffer = Parser::Source::Buffer.new filename
        buffer.read
        puts buffer.source
        puts
        # pretty print with colors!
      end
    end

  end
end
