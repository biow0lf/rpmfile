require 'childprocess'
require 'tempfile'

require_relative './basic'
require_relative './changelog'
require_relative './extra'

module RPM
  class File
    include Basic
    include Changelog
    include Extra

    # Public: Returns rpm file name as String.
    attr_reader :file

    # Public: Returns Boolean value of rpm type. Source or not.
    attr_reader :source

    # Public: Initialize RPM File.
    #
    # name   - A String with file name.
    # source - A Boolean value. Source rpm or not (default: false).
    # rpm    - RPM version (default: 'rpm5'). Variants: 'rpm5', 'fedora', 'altlinux'.
    def initialize(file, source = false, rpm = 'rpm5')
      @file = file
      @source = source
    end

    # TODO: EXCLUDEARCH
    #   EXCLUDEOS

    # def exclusivearch
    #   @exclusivearch ||= begin
    #     content = read_raw('[%{EXCLUSIVEARCH}\n]')
    #     content = content.split("\n") if content
    #     content
    #   end
    # end

    # TODO: EXCLUSIVEOS

    # Public: Return package OPTFLAGS from rpm file.
    #
    # Examples
    #
    #   optflags()
    #   # => "-O2 -g -pipe -Wall ..."
    #
    #   optflags()
    #   # => nil
    #
    # Returns package OPTFLAGS as String or nil if source rpm.
    def optflags
      @optflags ||= read_tag('OPTFLAGS') unless source
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
    # Returns platform as String or nil if source rpm.
    def platform
      @platform ||= read_tag('PLATFORM') unless source
    end

    # Public: Return package serial from rpm file. Fresh fedora 20+
    #   (maybe older) rpm dont know about 'SERIAL'.
    #
    # Examples
    #
    #   serial()
    #   # => nil
    #
    # Returns package serial as String or nil if serial is empty.
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
    # Returns package filename as String.
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
    # Returns tag content as String.
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
    # Returns specfilename as String or nil.
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
    # Returns Array of provides or nil for source rpm.
    def p
      return if source
      @p ||= provides.map { |provide| provide[:name] }
    end

    def requires
      # Requires and BuildRequires are the same for source rpm,
      # but we will treat them separately
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
      return if source
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
      return if source
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
