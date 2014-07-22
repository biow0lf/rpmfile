require 'childprocess'
require 'tempfile'

module RPM
  class File
    attr_reader :file

    def initialize(file)
      @file = file
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
    # Return tag content String.
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
      read_tag('NAME')
    end

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
      read_tag('VERSION')
    end

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
      read_tag('RELEASE')
    end

    # Public: Return package epoch from rpm file.
    #
    # Examples
    #
    #   epoch()
    #   # => nil
    #
    #   epoch()
    #   # => "2"
    #
    # Returns package epoch String or nil if epoch is empty.
    def epoch
      read_tag('EPOCH')
    end

    # Public: Return package serial from rpm file.
    #
    # Examples
    #
    #   serial()
    #   # => nil
    #
    # Returns package serial String or nil if serial is empty.
    def serial
      read_tag('SERIAL')
    end

    # Public: Return package file name.
    #
    # Examples
    #
    #   filename()
    #   # => "repocop-unittest-vendor-tag-0.5-alt1.src.rpm"
    #
    # Returns package file name.
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

    def sourcerpm
      read_tag('SOURCERPM')
    end

    def arch
      read_tag('ARCH')
    end

    def md5
      Digest::MD5.file(file).hexdigest
    end

    def file_size
      ::File.size(file)
    end

    def fileflags_with_filenames
      queryformat = '[%{FILEFLAGS} %{FILENAMES}\n]'
      read_array(queryformat)
    end

    def specfile
      # def self.import(branch, file, srpm)
      #   specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{file}" | grep \"32 \" | sed -e 's/32 //'`
      #   specfilename.strip!
      #   spec = `rpm2cpio "#{file}" | cpio -i --quiet --to-stdout "#{specfilename}"`
      #   spec.force_encoding('binary')
      #
      #   specfile = Specfile.new
      #   specfile.srpm_id = srpm.id
      #   specfile.branch_id = branch.id
      #   specfile.spec = spec
      #   specfile.save!
      # end

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

    # FIXME: this code is broken
    #  def self.import_provides(rpm, package)
    #    rpm.provides.each do |p|
    #      provide = Provide.new
    #      provide.package = package
    #      provide.name = p.name
    #      provide.version = p.version.v
    #      provide.release = p.version.r
    #      provide.epoch = p.version.e
    #      provide.flags = p.flags
    #      provide.save!
    #    end
    #  end

    # FIXME: this code is broken
    #  def self.import_requires(rpm, package)
    #    rpm.requires.each do |r|
    #      req = Require.new
    #      req.package = package
    #      req.name = r.name
    #      req.version = r.version.v
    #      req.release = r.version.r
    #      req.epoch = r.version.e
    #      req.flags = r.flags
    #      req.save!
    #    end
    #  end

    # class Rpm
    #   def self.check_md5(file)
    #     output = `export LANG=C && rpm -K --nogpg #{file}`
    #     if !output.empty? && output.chop.split(': ').last == 'md5 OK'
    #       true
    #     else
    #       false
    #     end
    #   end
    # end
    #
    # RPM = Rpm

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

    # def self.import(branch, file, srpm)
    #   specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{file}" | grep \"32 \" | sed -e 's/32 //'`
    #   specfilename.strip!
    #   spec = `rpm2cpio "#{file}" | cpio -i --quiet --to-stdout "#{specfilename}"`
    #   spec.force_encoding('binary')
    #
    #   specfile = Specfile.new
    #   specfile.srpm_id = srpm.id
    #   specfile.branch_id = branch.id
    #   specfile.spec = spec
    #   specfile.save!
    # end


    # def size
    #   read_tag('SIZE')
    # end

    # def self.import(branch, file, srpm)
    #   changelogs = `export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{file}`
    #   changelogs.force_encoding('binary')
    #   changelogs = changelogs.split("\n**********\n")
    #   while !changelogs.empty?
    #     record = changelogs.slice!(0..2)
    #     changelog = Changelog.new
    #     changelog.srpm_id = srpm.id
    #     changelog.changelogtime = record[0]
    #     changelog.changelogname = record[1]
    #     changelog.changelogtext = record[2]
    #     changelog.save!
    #   end
    # end

    # FIXME: this code broken
    #  def self.import_conflicts(rpm, package)
    #    rpm.conflicts.each do |c|
    #      conflict = Conflict.new
    #      conflict.package = package
    #      conflict.name = c.name
    #      conflict.version = c.version.v
    #      conflict.release = c.version.r
    #      conflict.epoch = c.version.e
    #      conflict.flags = c.flags
    #      conflict.save!
    #    end
    #  end

    # FIXME: this code is broken
    #  def self.import_obsoletes(rpm, package)
    #    rpm.obsoletes.each do |o|
    #      obsolete = Obsolete.new
    #      obsolete.package = package
    #      obsolete.name = o.name
    #      obsolete.version = o.version.v
    #      obsolete.release = o.version.r
    #      obsolete.epoch = o.version.e
    #      obsolete.flags = o.flags
    #      obsolete.save!
    #    end
    #  end


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
