require 'coderay'

module RealWorldRails
  module Inspectors

    class ViewSpecsInspector < Inspector

      inspects :specs, %r{/views/}

      def inspect_file(filename)
        puts formatted_filename(filename)
        buffer = create_buffer(filename)
        pretty_print_source buffer.source
        puts
      end
    end

  end
end
