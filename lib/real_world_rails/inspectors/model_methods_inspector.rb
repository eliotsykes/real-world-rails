module RealWorldRails
  module Inspectors

    class ModelMethodsInspector < Inspector

      def files_pattern
        raise 'Remove specs and tests'
        "apps/**/models/**/*.rb"
      end

      class Processor < Parser::AST::Processor
        def on_def(node)
          expression = node.location.expression
          filename = expression.source_buffer.name
          puts "File: #{filename}"
          puts expression.source
        end
      end

    end

  end
end
