require 'coderay'

module RealWorldRails
  module Inspectors

    class ViewSpecsInspector < Inspector

      inspects :specs, %r{/views/}

      def inspect_file(filename)
        puts formatted_filename(filename)
        buffer = create_buffer(filename)
        puts CodeRay.scan(buffer.source, :ruby).terminal(line_numbers: true)
        puts
      end
    end

  end
end
