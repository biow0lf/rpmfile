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

      # Public: Return package epoch from rpm file.
      #
      # Examples
      #
      #   epoch()
      #   # => nil
      #
      #   epoch()
      #   # => 2
      #
      # Returns package epoch as Integer or nil if epoch is empty.
      def epoch
        @epoch ||= begin
          value = read_tag('EPOCH')
          value = value.to_i if value
          value
        end
      end

      # Public: Return package epoch from rpm file. Alias for epoch().
      #
      # Examples
      #
      #   e()
      #   # => nil
      #
      #   e()
      #   # => 2
      #
      # Returns package epoch as Integer or nil if epoch is empty.
      alias :e :epoch

      # Public: Return package summary from rpm file.
      #
      # Examples
      #
      #   summary()
      #   # => "The GNU libc libraries"
      #
      # Returns package summary as String.
      def summary
        @summary ||= read_tag('SUMMARY')
      end

      # Public: Return package group from rpm file.
      #
      # Examples
      #
      #   group()
      #   # => "System Environment/Libraries"
      #
      # Returns package group as String.
      def group
        @group ||= read_tag('GROUP')
      end

      # Public: Return package license from rpm file.
      #
      # Examples
      #
      #   license()
      #   # => "LGPLv2+ and LGPLv2+ with exceptions and GPLv2+"
      #
      # Returns package license as String.
      def license
        @license ||= read_tag('LICENSE')
      end

      # Public: Return package url from rpm file.
      #
      # Examples
      #
      #   url()
      #   # => "http://www.gnu.org/software/glibc/"
      #
      #   url()
      #   # => nil
      #
      # Returns package url as String or nil if package url is empty.
      def url
        @url ||= read_tag('URL')
      end

      # Public: Return packager from rpm file.
      #
      # Examples
      #
      #   packager()
      #   # => "Fedora Project"
      #
      # Returns packager info as String.
      def packager
        @packager ||= read_tag('PACKAGER')
      end

      # Public: Return package vendor from rpm file.
      #
      # Examples
      #
      #   vendor()
      #   # => "Fedora Project"
      #
      # Returns package vendor as String.
      def vendor
        @vendor ||= read_tag('VENDOR')
      end

      # Public: Return package distribution from rpm file.
      #
      # Examples
      #
      #   distribution()
      #   # => "Fedora Project"
      #
      # Returns package distribution as String.
      def distribution
        @distribution ||= read_tag('DISTRIBUTION')
      end

      # Public: Return package description from rpm file.
      #
      # Examples
      #
      #   description()
      #   # => "The glibc package contains standard libraries which are..."
      #
      # Returns package description as String.
      def description
        @description ||= read_tag('DESCRIPTION')
      end

      # Public: Return architecture from rpm file.
      #
      # Examples
      #
      #   arch()
      #   # => "i686"
      #
      #   arch()
      #   # => "x86_64"
      #
      #   arch()
      #   # => "noarch"
      #
      #   arch()
      #   # => "armv7hl"
      #
      #   arch()
      #   # => nil
      #
      # Returns architecture of rpm file as String or nil if rpm is source rpm.
      def arch
        @arch ||= read_tag('ARCH') unless source
      end

      # Public: Return buildhost from rpm file.
      #
      # Examples
      #
      #   buildhost()
      #   # => "arm02-builder05.arm.fedoraproject.org"
      #
      # Returns package buildhost as String.
      def buildhost
        @buildhost ||= read_tag('BUILDHOST')
      end

      # Public: Return package build time from rpm file.
      #
      # Examples
      #
      #   buildtime()
      #   # => 2014-02-06 13:20:48 +0200
      #
      # Returns package build time as Time.
      def buildtime
        @buildtime ||= Time.at(read_tag('BUILDTIME').to_i)
      end

      # Public: Return source rpm filename from rpm file.
      #
      # Examples
      #
      #   sourcerpm()
      #   # => nil
      #
      #   sourcerpm()
      #   # => "glibc-2.18-13.fc20.src.rpm"
      #
      # Returns source rpm filename as String or nil if rpm is source rpm.
      def sourcerpm
        @sourcerpm ||= read_tag('SOURCERPM') unless source
      end

    end
  end
end
