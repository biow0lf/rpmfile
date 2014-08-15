require 'childprocess'
require 'tempfile'

module RPM
  class File
    # Public: Returns the String rpm file name.
    attr_reader :file

    # Public: Returns Boolean value of rpm type.
    #         Source or not.
    attr_reader :source

    # Public: Initialize RPM File.
    #
    # name - A String with file name.
    # source - A Boolean value. Source rpm or not (default: false).
    def initialize(file, source = false)
      @file = file
      @source = source
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

    # TODO: ARCHIVESIZE

    # Public: Return buildhost from rpm file.
    #
    # Examples
    #
    #   buildhost()
    #   # => "arm02-builder05.arm.fedoraproject.org"
    #
    # Returns package buildhost String.
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

    # TODO: CLASSDICT
    #   COLLECTIONS
    #   COOKIE
    #   DBINSTANCE
    #   DEPENDSDICT

    # Public: Return package description from rpm file.
    #
    # Examples
    #
    #   description()
    #   # => "The glibc package contains standard libraries which are..."
    #
    # Returns package description String.
    def description
      @description ||= read_tag('DESCRIPTION')
    end

    # Public: Return package distribution from rpm file.
    #
    # Examples
    #
    #   distribution()
    #   # => "Fedora Project"
    #
    # Returns package distribution String.
    def distribution
      @distribution ||= read_tag('DISTRIBUTION')
    end

    # TODO: DISTTAG
    #   DISTURL
    #   DSAHEADER

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
    # Returns package epoch Integer or nil if epoch is empty.
    def e
      epoch
    end

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
    # Returns package epoch Integer or nil if epoch is empty.
    def epoch
      @epoch ||= read_tag('EPOCH').to_i
    end

    # TODO: EPOCHNUM

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
    # Returns package Epoch-Version-Release String.
    def evr
      @evr ||= read_tag('EVR')
    end

    # TODO: EXCLUDEARCH
    #   EXCLUDEOS
    #   EXCLUSIVEARCH
    #   EXCLUSIVEOS
    #   GIF

    # Public: Return package group from rpm file.
    #
    # Examples
    #
    #   group()
    #   # => "System Environment/Libraries"
    #
    # Returns package group String.
    def group
      @group ||= read_tag('GROUP')
    end

    # TODO: HDRID
    #   HEADERCOLOR
    #   HEADERI18NTABLE
    #   HEADERIMAGE
    #   HEADERIMMUTABLE
    #   HEADERREGIONS
    #   HEADERSIGNATURES
    #   ICON
    #   INSTALLCOLOR
    #   INSTALLTID
    #   INSTALLTIME
    #   INSTFILENAMES
    #   INSTPREFIXES

    # Public: Return package license from rpm file.
    #
    # Examples
    #
    #   license()
    #   # => "LGPLv2+ and LGPLv2+ with exceptions and GPLv2+"
    #
    # Returns package license String.
    def license
      @license ||= read_tag('LICENSE')
    end

    # TODO: LONGARCHIVESIZE
    #   LONGFILESIZES
    #   LONGSIGSIZE
    #   LONGSIZE

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
    # Returns package name String.
    def n
      name
    end

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
    # Returns package name String.
    def name
      @name ||= read_tag('NAME')
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
    # Returns name-epoch:version-release.arch as String.
    def nevra
      @nevra ||= read_tag('NEVRA')
    end

    # TODO: NOPATCH
    #   NOSOURCE

    # Public: Return package name-version-release from rpm file.
    #
    # Examples
    #
    #   nvr()
    #   # => "tar-1.26-31.fc20"
    #
    # Returns name-version-release String.
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
    # Returns name-version-release.arch String.
    def nvra
      @nvra ||= read_tag('NVRA')
    end

    # Public: Return package OPTFLAGS from rpm file.
    #
    # Examples
    #
    #   optflags()
    #   # => "-O2 -g -pipe -Wall ..."
    #
    # Returns package OPTFLAGS as String or nil if OPTFLAGS is empty.
    def optflags
      @optflags ||= read_tag('OPTFLAGS')
    end

    # Public: Return packager from rpm file.
    #
    # Examples
    #
    #   packager()
    #   # => "Fedora Project"
    #
    # Returns packager info String.
    def packager
      @packager ||= read_tag('PACKAGER')
    end

    # Public: Return platform from rpm file.
    #
    # Examples
    #
    #   platform()
    #   # => "x86_64-redhat-linux-gnu"
    #
    #   platform()
    #   # => "armv7hl-redhat-linux-gnueabi"
    #
    # Returns platform String.
    def platform
      @platform ||= read_tag('PLATFORM') unless source
    end

    # TODO: POSTIN
    #   POSTINFLAGS
    #   POSTINPROG
    #   POSTTRANS
    #   POSTTRANSFLAGS
    #   POSTTRANSPROG
    #   POSTUN
    #   POSTUNFLAGS
    #   POSTUNPROG
    #   PREFIXES
    #   PREIN
    #   PREINFLAGS
    #   PREINPROG
    #   PRETRANS
    #   PRETRANSFLAGS
    #   PRETRANSPROG
    #   PREUN
    #   PREUNFLAGS
    #   PREUNPROG

    # TODO: PUBKEYS

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
    # Returns package release String.
    def r
      release
    end

    # TODO: RECONTEXTS

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
    # Returns package release String.
    def release
      @release ||= read_tag('RELEASE')
    end

    # TODO: REMOVETID

    # TODO: RPMVERSION
    #   RSAHEADER
    #   SHA1HEADER
    #   SIGGPG
    #   SIGMD5
    #   SIGPGP
    #   SIGSIZE
    #   SIZE

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
      @sourcerpm ||= read_tag('SOURCERPM')
    end

    # Public: Return package summary from rpm file.
    #
    # Examples
    #
    #   summary()
    #   # => "The GNU libc libraries"
    #
    # Returns package summary String.
    def summary
      @summary ||= read_tag('SUMMARY')
    end

    # TODO: TRIGGERCONDS
    #   TRIGGERFLAGS
    #   TRIGGERINDEX
    #   TRIGGERNAME
    #   TRIGGERSCRIPTFLAGS
    #   TRIGGERSCRIPTPROG
    #   TRIGGERSCRIPTS
    #   TRIGGERTYPE
    #   TRIGGERVERSION

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
    # Returns package url String or nil if package url is empty.
    def url
      @url ||= read_tag('URL')
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
    # Returns package version String.
    def v
      version
    end

    # TODO: VCS

    # Public: Return package vendor from rpm file.
    #
    # Examples
    #
    #   vendor()
    #   # => "Fedora Project"
    #
    # Returns package vendor String.
    def vendor
      @vendor ||= read_tag('VENDOR')
    end

    # TODO: VERBOSE
    #   VERIFYSCRIPT
    #   VERIFYSCRIPTFLAGS
    #   VERIFYSCRIPTPROG

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
    # Returns package version String.
    def version
      @version ||= read_tag('VERSION')
    end

    # TODO: XPM

    # Public: Return package serial from rpm file. Fresh fedora 20+
    #   (maybe older) rpm dont know about 'SERIAL'.
    #
    # Examples
    #
    #   serial()
    #   # => nil
    #
    # Returns package serial String or nil if serial is empty.
    def serial
      @serial ||= read_tag('SERIAL')
    end

    # Public: Return package file name.
    #
    # Examples
    #
    #   filename()
    #   # => "glibc-2.18-13.fc20.src.rpm"
    #
    #   filename()
    #   # => "glibc-2.18-13.fc20.i686.rpm"
    #
    # Returns package filename String.
    def filename
      @filename ||= begin
        if source
          "#{ name }-#{ version }-#{ release }.src.rpm"
        else
          "#{ name }-#{ version }-#{ release }.#{ arch }.rpm"
        end
      end
    end

    # Public: Return package md5 sum of rpm file.
    #
    # Examples
    #
    #   md5()
    #   #=> "59866f10b259a9f1d401cb48e6dda048"
    #
    # Returns package md5 sum as String.
    def md5
      @md5 ||= Digest::MD5.file(file).hexdigest
    end

    # Public: Return rpm file size.
    #
    # Examples
    #
    #   filesize()
    #   # => 22447235
    #
    # Returns rpm file size as Fixnum.
    def filesize
      @filesize ||= ::File.size(file)
    end

    # Internal: Read tag via rpm binary.
    #
    # Examples
    #
    #   read_tag('NAME')
    #   # => "glibc"
    #
    #   read_tag('VERSION')
    #   # => "2.18"
    #
    #   read_tag('RELEASE')
    #   # => "13.fc20"
    #
    # Returns tag content String.
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

    def read_array(queryformat)
      process = ChildProcess.build('rpm', '-qp', "--queryformat=#{ queryformat }", file)
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
      output = []
      return unless content
      content.split("\n").each do |line|
        output << line.split(' ')
      end
      output
    end

    def read_raw(queryformat)
      process = ChildProcess.build('rpm', '-qp', "--queryformat=#{ queryformat }", file)
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

    def fileflags_with_filenames
      queryformat = '[%{FILEFLAGS} %{FILENAMES}\n]'
      read_array(queryformat)
    end

    # Public: Return spec file name from source rpm.
    #
    # Examples
    #
    #   specfilename()
    #   # => "tar.spec"
    #
    #   specfilename()
    #   # => nil
    #
    # Returns specfilename String or nil.
    def specfilename
      @specfilename ||= fileflags_with_filenames.reject! { |line| line[0] == '0' }[0][1] if source
    end

    # Public: Return content of spec file from source rpm.
    #
    # Examples
    #
    #   specfile()
    #   # => "%define glibcsrcdir glibc-2.18\n%define glibcversion 2.18\n..."
    #
    #   specfile()
    #   # => nil
    #
    # Returns content of spec file as String or nil.
    def specfile
      @specfile ||= extract_file(specfilename) if source
    end

    def extract_file(filename)
      cpio           = ChildProcess.build('cpio', '-i', '--quiet', '--to-stdout', filename)
      cpio.duplex    = true # sets up pipe so cpio.io.stdin will be available after .start
      cpio.io.stdout = Tempfile.new('extracted_file')
      cpio.start

      rpm2cpio           = ChildProcess.build('rpm2cpio', file)
      rpm2cpio.io.stdout = cpio.io.stdin
      rpm2cpio.start
      rpm2cpio.wait

      cpio.io.stdin.close
      cpio.wait
      cpio.io.stdout.rewind
      content = cpio.io.stdout.read
      cpio.io.stdout.close
      cpio.io.stdout.unlink
      # content.force_encoding('binary')
      content
    end

    def build_requires
      return unless source
      @build_requires ||= begin
        queryformat = '[%{REQUIRENAME} %{REQUIREFLAGS:deptype} %{REQUIREFLAGS:depflags} %{REQUIREVERSION}\n]'
        array = read_array(queryformat)
        output = []
        array.each do |record|
          output << { name: record[0],
                      deptype: record[1],
                      depflags: record[2],
                      version: record[3] }
        end
        output
      end
    end

    def provides
      return if source
      @provides ||= begin
        queryformat = '[%{PROVIDENAME} %{PROVIDEFLAGS:deptype} %{PROVIDEFLAGS:depflags} %{PROVIDEVERSION}\n]'
        array = read_array(queryformat)
        output = []
        return unless array
        array.each do |record|
          output << { name: record[0],
                      deptype: record[1],
                      depflags: record[2],
                      version: record[3] }
        end
        output
      end
    end

    # Public: Short version of provides(). Return only names.
    #
    # Examples
    #
    #   p()
    #   # => ["/bin/gtar", "/bin/tar", "bundled(gnulib)", "tar", "tar(x86-64)"]
    #
    # Returns Array of provides.
    def p
      @p ||= provides.map { |provide| provide[:name] }
    end

    def requires
      return if source
      @requires ||= begin
        queryformat = '[%{REQUIRENAME} %{REQUIREFLAGS:deptype} %{REQUIREFLAGS:depflags} %{REQUIREVERSION}\n]'
        array = read_array(queryformat)
        output = []
        return unless array
        array.each do |record|
          output << { name: record[0],
                      deptype: record[1],
                      depflags: record[2],
                      version: record[3] }
        end
        output
      end
    end

    def conflicts
      return if source
      @conflicts ||= begin
        queryformat = '[%{CONFLICTNAME} %{CONFLICTFLAGS:deptype} %{CONFLICTFLAGS:depflags} %{CONFLICTVERSION}\n]'
        array = read_array(queryformat)
        output = []
        return unless array
        array.each do |record|
          output << { name: record[0],
                      deptype: record[1],
                      depflags: record[2],
                      version: record[3] }
        end
        output
      end
    end

    # Public: Short version of conflicts(). Return only names.
    #
    # Examples
    #
    #   c()
    #   # => ["kernel", "binutils", "prelink"]
    #
    # Returns Array of conflicts.
    def c
      @c ||= conflicts.map { |conflict| conflict[:name] }
    end

    def obsoletes
      return if source
      @obsoletes ||= begin
        queryformat = '[%{OBSOLETENAME} %{OBSOLETEFLAGS:deptype} %{OBSOLETEFLAGS:depflags} %{OBSOLETEVERSION}\n]'
        array = read_array(queryformat)
        output = []
        return unless array
        array.each do |record|
          output << { name: record[0],
                      deptype: record[1],
                      depflags: record[2],
                      version: record[3] }
        end
        output
      end
    end

    # Public: Short version of obsoletes(). Return only names.
    #
    # Examples
    #
    #   o()
    #   # => ["glibc-profile", "nss_db"]
    #
    # Returns Array of obsoletes.
    def o
      @o ||= obsoletes.map { |obsolete| obsolete[:name] }
    end

    def changelogs
      @changelogs ||= begin
        queryformat = '[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]'
        raw = read_raw(queryformat)
        # raw.force_encoding('binary')
        raw = raw.split("\n**********\n")
        output = []
        until raw.empty?
          record = raw.slice!(0..2)
          output << { changelogtime: Time.at(record[0].to_i),
                      changelogname: record[1],
                      changelogtext: record[2] }
        end
        output
      end
    end

    def self.check_md5(file)
      process = ChildProcess.build('rpm', '-K', file)
      process.environment['LANG'] = 'C'
      process.io.stdout = Tempfile.new('child-output')
      process.start
      process.wait
      process.io.stdout.rewind
      content = process.io.stdout.read
      process.io.stdout.close
      process.io.stdout.unlink
      if !content.empty? && content.chop.split(': ').last == 'sha1 md5 OK'
        true
      else
        false
      end
    end

    # def self.import(branch, file, srpm)
    #   files = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{file}`
    #   hsh = {}
    #   files.split("\n").each do |line|
    #     hsh[line.split("\t")[0]] = line.split("\t")[1]
    #   end
    #   patches = `rpmquery --qf '[%{PATCH}\n]' -p #{file}`
    #   patches.split("\n").each do |filename|
    #     patch = Patch.new
    #
    #     # DON'T import patch if size is more than 512k
    #     if hsh[filename].to_i <= 1024 * 512
    #       content = `rpm2cpio "#{file}" | cpio -i --quiet --to-stdout "#{filename}"`
    #       patch.patch = content.force_encoding('BINARY')
    #     end
    #
    #     patch.size = hsh[filename].to_i
    #     patch.filename = filename
    #     patch.branch_id = branch.id
    #     patch.srpm_id = srpm.id
    #     patch.save!
    #   end
    # end

    # def self.import(branch, file, srpm)
    #   files = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{file}`
    #   hsh = {}
    #   files.split("\n").each do |line|
    #     hsh[line.split("\t")[0]] = line.split("\t")[1]
    #   end
    #   sources = `rpmquery --qf '[%{SOURCE}\n]' -p #{file}`
    #   sources.split("\n").each do |filename|
    #     source = Source.new
    #
    #     # DON'T import source if size is more than 512k
    #     if hsh[filename].to_i <= 1024 * 512
    #       content = `rpm2cpio "#{file}" | cpio -i --quiet --to-stdout "#{filename}"`
    #       source.source = content.force_encoding('BINARY')
    #     end
    #
    #     source.size = hsh[filename].to_i
    #     source.filename = filename
    #     source.branch_id = branch.id
    #     source.srpm_id = srpm.id
    #     source.save!
    #   end
    # end

  end
end

# BASENAMES
# DIRINDEXES
# DIRNAMES

# FILECAPS
# FILECLASS
# FILECOLORS
# FILECONTEXTS
# FILEDEPENDSN
# FILEDEPENDSX
# FILEDEVICES
# FILEDIGESTALGO
# FILEDIGESTS
# FILEFLAGS
# FILEGROUPNAME
# FILEINODES
# FILELANGS
# FILELINKTOS
# FILEMD5S
# FILEMODES
# FILEMTIMES
# FILENAMES
# FILENLINKS
# FILEPROVIDE
# FILERDEVS
# FILEREQUIRE
# FILESIZES
# FILESTATES
# FILEUSERNAME
# FILEVERIFYFLAGS
# FSCONTEXTS

# OLDFILENAMES

# ORDERFLAGS
# ORDERNAME
# ORDERVERSION
# ORIGBASENAMES
# ORIGDIRINDEXES
# ORIGDIRNAMES
# ORIGFILENAMES
# OS

# PATCH
# PATCHESFLAGS
# PATCHESNAME
# PATCHESVERSION
# PAYLOADCOMPRESSOR
# PAYLOADFLAGS
# PAYLOADFORMAT
# PKGID

# POLICIES
# POLICYFLAGS
# POLICYNAMES
# POLICYTYPES
# POLICYTYPESINDEXES

# SOURCE
# SOURCEPACKAGE
# SOURCEPKGID
