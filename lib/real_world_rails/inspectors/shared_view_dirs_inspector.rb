require 'tty'

module RealWorldRails
  module Inspectors

    class SharedViewDirsInspector < Inspector

      inspects :views

      def files_pattern
        "apps/**/*"
      end

      def inspectable?(filename)
        File.directory?(filename) && self.class.filename_specification.satisfied_by?(filename)
      end

      def before_inspect_files
        puts "Searching the shared view directory used by each Rails app."
        puts "The following directory names are assumed to be shared view directories:"
        puts "shared, common, partials, application"
      end

      def inspect_file(dirname)
        SharedViewDir.add_if_shared dirname
      end

      def after_inspect_files
        SharedViewDir.report
      end

      class SharedViewDir

        @@store = {}

        PROJECT_SHARED_VIEW_DIR_REGEXP = %r{\Aapps/(?<project>.+)(/.+)?/app/views/(?<shared_view_dir>shared|common|partials|application)\z}

        def self.add_if_shared(dirname)
          project, shared_view_dir = extract_project_and_shared_view_dir(dirname)
          return unless project && shared_view_dir
          projects = @@store[shared_view_dir] || []
          projects << "#{project} (#{dirname})"
          @@store[shared_view_dir] = projects
        end

        def self.report
          analyze_view_directories
        end

        def self.analyze_view_directories
          headers = ["Shared\nDir Name", "Usage\nCount", 'Projects']
          rows = @@store.map do |shared_view_dir, projects|
            [shared_view_dir, projects.size, projects.join("\n")]
          end
          rows.sort_by! { |row| -(count = row[1]) }
          table = TTY::Table.new headers, rows
          puts table.render(:unicode, alignments: [:right, :right, :left], multiline: true, border: {separator: :each_row})
        end

        private

        def self.extract_project_and_shared_view_dir(dirname)
          match = PROJECT_SHARED_VIEW_DIR_REGEXP.match(dirname)
          return match[:project], match[:shared_view_dir] if match
        end

      end
    end

  end
end
