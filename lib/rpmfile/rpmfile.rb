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

    def name
      read_tag('NAME')
    end

    def version
      read_tag('VERSION')
    end

    def release
      read_tag('RELEASE')
    end

    def epoch
      read_tag('EPOCH')
    end

    def serial
      read_tag('SERIAL')
    end

    # if str == "" then: str = nil

    # srpm.filename = "#{srpm.name}-#{srpm.version}-#{srpm.release}.src.rpm"

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

    # srpm.size = File.size(file)
    # srpm.md5 = `/usr/bin/md5sum #{file}`.split[0]

    # srpm.changelogtime = Time.at(`export LANG=C && rpm -qp --queryformat='%{CHANGELOGTIME}' #{file}`.to_i)
    #
    # changelogname = `export LANG=C && rpm -qp --queryformat='%{CHANGELOGNAME}' #{file}`
    # srpm.changelogname = changelogname
    #
    # srpm.changelogtext = `export LANG=C && rpm -qp --queryformat='%{CHANGELOGTEXT}' #{file}`
    #
    # email = srpm.changelogname.chop.split('<')[1].split('>')[0] rescue nil

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
# CHANGELOGTIME
# CHANGELOGNAME
# CHANGELOGTEXT
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
