module RPM
  class File
    module Basic
      # Public: Return package name from rpm file.
      #
      # Examples
      #
      #   name()
      #   # => "glibc"
      #
      #   name()
      #   # => "bash"
      #
      #   name()
      #   # => "tar"
      #
      # Returns package name as String.
      def name
        @name ||= read_tag('NAME')
      end

      # Public: Return package name from rpm file. Alias for name().
      #
      # Examples
      #
      #   n()
      #   # => "glibc"
      #
      #   n()
      #   # => "bash"
      #
      #   n()
      #   # => "tar"
      #
      # Returns package name as String.
      alias :n :name

      # Public: Return package version from rpm file.
      #
      # Examples
      #
      #   version()
      #   # => "2.18"
      #
      #   version()
      #   # => "4.2.47"
      #
      #   version()
      #   # => "1.26"
      #
      # Returns package version as String.
      def version
        @version ||= read_tag('VERSION')
      end

      # Public: Return package version from rpm file. Alias for version().
      #
      # Examples
      #
      #   v()
      #   # => "2.18"
      #
      #   v()
      #   # => "4.2.47"
      #
      #   v()
      #   # => "1.26"
      #
      # Returns package version as String.
      alias :v :version

      # Public: Return package release from rpm file.
      #
      # Examples
      #
      #   release()
      #   # => "13.fc20"
      #
      #   release()
      #   # => "3.fc20"
      #
      #   release()
      #   # => "31.fc20"
      #
      # Returns package release as String.
      def release
        @release ||= read_tag('RELEASE')
      end

      # Public: Return package release from rpm file. Alias for release().
      #
      # Examples
      #
      #   r()
      #   # => "13.fc20"
      #
      #   r()
      #   # => "3.fc20"
      #
      #   r()
      #   # => "31.fc20"
      #
      # Returns package release as String.
      alias :r :release

    end
  end
end
