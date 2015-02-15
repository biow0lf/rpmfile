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
        # TODO: check if rpm support EVR tag and read it
        # @evr ||= read_tag('EVR')
        @evr ||= begin
          if epoch
            "#{ epoch }:#{ version }-#{ release }"
          else
            "#{ version }-#{ release }"
          end
        end
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
        # TODO: check if rpm support NEVR and read it
        # @nevr ||= read_tag('NEVR')
        @nevr ||= begin
          if epoch
            "#{ name }-#{ epoch }:#{ version }-#{ release }"
          else
            "#{ name }-#{ version }-#{ release }"
          end
        end
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
        # TODO: check if rpm support NEVRA tag and read it
        # @nevra ||= read_tag('NEVRA') unless source
        return nil if source
        @nevra ||= begin
          if epoch
            "#{ name }-#{ epoch }:#{ version }-#{ release }.#{ arch }"
          else
            "#{ name }-#{ version }-#{ release }.#{ arch }"
          end
        end
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
        # TODO: check if rpm support NVR tag and read it
        # @nvr ||= read_tag('NVR')
        @nvr ||= "#{ name }-#{ version }-#{ release }"
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
        # TODO: check if rpm support NVRA tag and read it
        # @nvra ||= read_tag('NVRA') unless source
        return nil if source
        @nvra ||= "#{ name }-#{ version }-#{ release }.#{ arch }"
      end

    end
  end
end
