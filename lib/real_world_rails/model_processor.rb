# require 'pp'
# require 'pry'

class ModelProcessor < Parser::AST::Processor

  def on_class(node)
    # binding.pry
    # pp node.inspect
    class_name = node.children.first.children.last
    puts class_name
  end

end