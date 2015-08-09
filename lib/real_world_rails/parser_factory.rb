require 'parser/current'

module ParserFactory

  def self.create
    parser = Parser::CurrentRuby.new
    parser.diagnostics.all_errors_are_fatal = false
    parser.diagnostics.ignore_warnings      = true
    parser.diagnostics.consumer = lambda do |diagnostic|
      puts(diagnostic.render)
    end
    parser
  end

end
