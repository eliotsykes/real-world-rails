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
        puts "shared, common, partials"
        puts "(exists, but contents?): imports, default, templates, widgets, files, sections, plugins"
      end

      def inspect_file(dirname)
        ViewDir.add_if_shared dirname
      end

      def after_inspect_files
        ViewDir.report
      end

      class ViewDir

        @@store = {}

        PROJECT_SHARED_VIEW_DIR_REGEXP = %r{\Aapps/(?<project>.+)(/.+)?/app/views/(?<shared_view_dir>shared|common|partials|imports|default|templates|widgets|files|sections|plugins)\z}

        def self.add_if_shared(dirname)
          match = PROJECT_SHARED_VIEW_DIR_REGEXP.match(dirname)
          return unless match
          shared_view_dir = match[:shared_view_dir]
          project = match[:project]
          project_shared_dirs = @@store[project] || []
          project_shared_dirs << shared_view_dir
          @@store[project] = project_shared_dirs
        end

        def self.report
          analyze_view_directories
        end

        def self.analyze_view_directories
          puts @@store
          # view_dirs = Set.new

          # @@store.each do |view_filename|
          #   view_dir = File.dirname(view_filename)
          #   view_dirs << view_dir
          # end
          #
          # view_home_regex = %r{.+/app/views/}
          # frequencies = Hash.new(0)
          #
          # view_dirs.each do |view_dir|
          #   relative_view_dir = view_dir.sub(view_home_regex, '')
          #   frequencies[relative_view_dir] += 1
          # end
          #
          # headers = ['Frequency', 'View Directory']
          # rows = frequencies.sort_by {|view_dir, freq| -freq}.map {|view_dir, freq| [freq, view_dir]}
          # table = TTY::Table.new headers, rows

          # puts table.render(:unicode, alignments: [:right, :left])
        end

      end
    end

  end
end
