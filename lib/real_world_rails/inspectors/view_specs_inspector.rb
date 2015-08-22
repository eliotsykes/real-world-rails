module RealWorldRails
  module Inspectors

    class ViewSpecsInspector < Inspector

      inspects :specs, %r{/views?/}

    end

  end
end
