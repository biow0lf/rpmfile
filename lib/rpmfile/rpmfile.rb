require 'childprocess'
require 'tempfile'

module RPM
  class File
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def read_tag(tag)
      process = ChildProcess.build('rpm', '-qp', "--queryformat=%{#{ tag }}", file)
      process.environment['LANG'] = 'C'
      process.io.stdout = Tempfile.new('child-output')
      process.start
      process.wait
      process.io.stdout.rewind
      content = process.io.stdout.read
      process.io.stdout.close
      process.io.stdout.unlink
      content = nil if content == '(none)'
      content = nil if content == ''
      content
    end

    # Public: Return package name from rpm file
    #
    # Examples:
    #
    #   name()
    #   # => "repocop-unittest-vendor-tag"
    #
    # Returns package name from rpm file
    def name
      read_tag('NAME')
    end

    # Public: Return package version from rpm file
    #
    # Examples:
    #
    #   version()
    #   # => "0.5"
    #
    # Returns package version from rpm file
    def version
      read_tag('VERSION')
    end

    # Public: Return package release from rpm file
    #
    # Examples:
    #
    #   release()
    #   # => "alt1"
    #
    # Returns package release from rpm file
    def release
      read_tag('RELEASE')
    end

    # Public: Return package epoch from rpm file
    #
    # Examples:
    #
    #   epoch()
    #   # => nil
    #
    # Returns package epoch from rpm file
    def epoch
      read_tag('EPOCH')
    end

    def serial
      read_tag('SERIAL')
    end

    def filename
      "#{ self.name }-#{ self.version }-#{ self.release }.src.rpm"
    end

    def group
      read_tag('GROUP')
    end

    def packager
      read_tag('PACKAGER')
    end

    def summary
      read_tag('SUMMARY')
    end

    # hack for very long summary in openmoko_dfu-util src.rpm
    # srpm.summary = 'Broken' if srpm.name == 'openmoko_dfu-util'

    def license
      read_tag('LICENSE')
    end

    def url
      read_tag('URL')
    end

    def description
      read_tag('DESCRIPTION')
    end

    def vendor
      read_tag('VENDOR')
    end

    def distribution
      read_tag('DISTRIBUTION')
    end

    def buildtime
      Time.at(read_tag('BUILDTIME').to_i)
    end

    def changelogtime
      Time.at(read_tag('CHANGELOGTIME').to_i)
    end

    def changelogname
      read_tag('CHANGELOGNAME')
    end

    def changelogtext
      read_tag('CHANGELOGTEXT')
    end

    def md5
      Digest::MD5.file(file).hexdigest
    end

    def file_size
      ::File.size(file)
    end

    # def size
    #   read_tag('SIZE')
    # end
  end
end

# HEADERIMAGE
# HEADERSIGNATURES
# HEADERIMMUTABLE
# HEADERREGIONS
# HEADERI18NTABLE
# SIGSIZE
# SIGPGP
# SIGMD5
# SIGGPG
# PUBKEYS
# DSAHEADER
# RSAHEADER
# SHA1HEADER
# BUILDHOST
# INSTALLTIME
# SIZE
# GIF
# XPM
# COPYRIGHT
# SOURCE
# PATCH
# OS
# ARCH
# PREIN
# POSTIN
# PREUN
# POSTUN
# OLDFILENAMES
# FILESIZES
# FILESTATES
# FILEMODES
# FILERDEVS
# FILEMTIMES
# FILEMD5S
# FILELINKTOS
# FILEFLAGS
# FILEUSERNAME
# FILEGROUPNAME
# ICON
# SOURCERPM
# FILEVERIFYFLAGS
# ARCHIVESIZE
# PROVIDENAME
# PROVIDES
# REQUIREFLAGS
# REQUIRENAME
# REQUIREVERSION
# CONFLICTFLAGS
# CONFLICTNAME
# CONFLICTVERSION
# EXCLUDEARCH
# EXCLUDEOS
# EXCLUSIVEARCH
# EXCLUSIVEOS
# RPMVERSION
# TRIGGERSCRIPTS
# TRIGGERNAME
# TRIGGERVERSION
# TRIGGERFLAGS
# TRIGGERINDEX
# VERIFYSCRIPT
# PREINPROG
# POSTINPROG
# PREUNPROG
# POSTUNPROG
# BUILDARCHS
# OBSOLETENAME
# OBSOLETES
# VERIFYSCRIPTPROG
# TRIGGERSCRIPTPROG
# COOKIE
# FILEDEVICES
# FILEINODES
# FILELANGS
# PREFIXES
# INSTPREFIXES
# SOURCEPACKAGE
# PROVIDEFLAGS
# PROVIDEVERSION
# OBSOLETEFLAGS
# OBSOLETEVERSION
# DIRINDEXES
# BASENAMES
# DIRNAMES
# OPTFLAGS
# DISTURL
# PAYLOADFORMAT
# PAYLOADCOMPRESSOR
# PAYLOADFLAGS
# INSTALLTID
# REMOVETID
# RHNPLATFORM
# PLATFORM
# PATCHESNAME
# PATCHESFLAGS
# PATCHESVERSION
# CACHECTIME
# CACHEPKGPATH
# CACHEPKGSIZE
# CACHEPKGMTIME
# FILECOLORS
# FILECLASS
# CLASSDICT
# FILEDEPENDSX
# FILEDEPENDSN
# DEPENDSDICT
# SOURCEPKGID
# FILENAMES
# FSSIZES
# FSNAMES
# INSTALLPREFIX
# TRIGGERCONDS
# TRIGGERTYPE
