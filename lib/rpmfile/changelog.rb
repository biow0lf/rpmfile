module RPM
  class File
    module Changelog
      # Public: Return last changelog name from rpm file.
      #
      # Examples
      #
      #   changelogname()
      #   # => "Siddhesh Poyarekar <siddhesh@redhat.com> - 2.18-13"
      #
      # Returns last changelog name as String.
      def changelogname
        @changelogname ||= read_tag('CHANGELOGNAME')
      end

      # Public: Return last changelog text from rpm file.
      #
      # Examples
      #
      #   changelogtext()
      #   # => "- Add pointer mangling support for ARM (#1019452)."
      #
      # Returns last changelog text as String.
      def changelogtext
        @changelogtext ||= read_tag('CHANGELOGTEXT')
      end

      # Public: Return last changelog time from rpm file.
      #
      # Examples
      #
      #   changelogtime()
      #   # => 2014-02-06 14:00:00 +0200
      #
      # Returns last changelog time as Time.
      def changelogtime
        @changelogtime ||= Time.at(read_tag('CHANGELOGTIME').to_i)
      end

    end
  end
end
