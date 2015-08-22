module RealWorldRails
  module Inspectors

    class ViewSpecsInspector < Inspector

      inspects :specs, %r{/views/}

      def inspect_file(filename)
        puts filename
      end
    end

  end
end
