module RPM
  class File
    module Extra
      # Public: Return package epoch:version-release from rpm file.
      #
      # Examples
      #
      #   evr()
      #   # => "2:1.26-31.fc20"
      #
      #   evr()
      #   # => "4.2.47-3.fc20"
      #
      # Returns package epoch-version-release as String.
      def evr
        @evr ||= read_tag('EVR')
      end

      # Public: Return package name-epoch:version-release from rpm file.
      #
      # Examples
      #
      #   nevr()
      #   # => "tar-2:1.26-31.fc20"
      #
      #   nevr()
      #   # => "bash-4.2.47-3.fc20"
      #
      # Returns name-epoch:version-release as String.
      def nevr
        @nevr ||= read_tag('NEVR')
      end

      # Public: Return package name-epoch:version-release.arch from rpm file.
      #
      # Examples
      #
      #   nevra()
      #   # => "tar-2:1.26-31.fc20.armv7hl"
      #
      #   nevra()
      #   # => "bash-4.2.47-3.fc20.armv7hl"
      #
      #   nevra()
      #   # => nil
      #
      # Returns name-epoch:version-release.arch as String or nil if package is source rpm.
      def nevra
        @nevra ||= read_tag('NEVRA') unless source
        raise 'FIXME'
      end

      # Public: Return package name-version-release from rpm file.
      #
      # Examples
      #
      #   nvr()
      #   # => "tar-1.26-31.fc20"
      #
      # Returns name-version-release as String.
      def nvr
        @nvr ||= read_tag('NVR')
      end

      # Public: Return package name-version-release.arch from rpm file.
      #
      # Examples
      #
      #   nvra()
      #   # => "tar-1.26-31.fc20.armv7hl"
      #
      #   nvra()
      #   # => nil
      #
      # Returns name-version-release.arch as String or nil if source rpm.
      def nvra
        @nvra ||= read_tag('NVRA') unless source
        raise 'FIXME'
      end

    end
  end
end
