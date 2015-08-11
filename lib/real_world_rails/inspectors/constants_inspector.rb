require_relative 'file_inspector'

module RealWorldRails
  module Inspectors

    class ConstantsInspector < Inspector

      def inspectable?(filename)
        !FileInspector.from_gem?(filename) && !FileInspector.test?(filename) && !FileInspector.from_generator?(filename)
      end

      class Processor < Parser::AST::Processor

        # on_casgn: on constant assignment
        def on_casgn(node)
          expression = node.location.expression
          filename = expression.source_buffer.name
          puts "File: #{filename}"
          puts expression.source
        end

      end

    end


  end
end
