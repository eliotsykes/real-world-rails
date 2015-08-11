module RealWorldRails
  module Inspectors

    class ModelsInspector < Inspector

      def files_pattern
        "**/models/**/*.rb"
      end

      class Processor < Parser::AST::Processor
        def on_class(node)
          class_name = node.children.first.children.last
          puts class_name
        end
      end
      
    end

  end
end
