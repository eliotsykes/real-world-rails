require 'coderay'

module RealWorldRails
  module Inspectors

    class ViewSpecsInspector < Inspector

      inspects :specs, %r{/views/}

      def inspect_file(filename)
        buffer = create_buffer(filename)
        pretty_print_source source: buffer.source, filename: filename
        puts
      end
    end

  end
end
