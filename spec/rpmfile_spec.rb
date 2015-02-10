require 'spec_helper'
require 'rpmfile'

describe 'RPM::File' do
  describe 'Basic tags' do

    context 'NAME' do
      it 'should return package name from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.name).to eq('tar')
      end

      it 'should return package name from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.name).to eq('tar')
      end

      it 'should return package name from source rpm (n() -> alias for name())' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.n).to eq('tar')
      end

      it 'should return package name from binary rpm (n() -> alias for name())' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.n).to eq('tar')
      end
    end

    context 'VERSION' do
      it 'should return package version from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.version).to eq('1.26')
      end

      it 'should return package version from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.version).to eq('1.26')
      end

      it 'should return package version from source rpm (v() -> alias for version()' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.v).to eq('1.26')
      end

      it 'should return package version from binary rpm (v() -> alias for version()' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.v).to eq('1.26')
      end
    end

    context 'RELEASE' do
      it 'should return package release from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.release).to eq('31.fc20')
      end

      it 'should return package release from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.release).to eq('31.fc20')
      end

      it 'should return package release from source rpm (r() -> alias for release()' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.r).to eq('31.fc20')
      end

      it 'should return package release from binary rpm (r() -> alias for release()' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.r).to eq('31.fc20')
      end
    end

    context 'EPOCH' do
      it 'should return package epoch from rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.epoch).to eq(2)
      end

      # TODO: WTF??
      it 'should return package epoch as Fixnum from rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.epoch).to be_an_instance_of(Fixnum)
      end

      it 'should return package epoch as nil if epoch is empty' do
        rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
        expect(rpm.epoch).to eq(nil)
      end

      it 'should return package epoch from rpm (e() -> alias for epoch())' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.e).to eq(2)
      end
    end

    context 'SUMMARY' do
      it 'should return package summary from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.summary).to eq('A GNU file archiving program')
      end

      it 'should return package summary from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.summary).to eq('A GNU file archiving program')
      end
    end

    context 'GROUP' do
      it 'should return package group from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.group).to eq('Applications/Archiving')
      end

      it 'should return package group from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.group).to eq('Applications/Archiving')
      end
    end

    context 'LICENSE' do
      it 'should return package license from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.license).to eq('GPLv3+')
      end

      it 'should return package license from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.license).to eq('GPLv3+')
      end
    end

  end

=begin

  describe 'ARCH tag' do
    it 'should return arch from source rpm' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
      expect(rpm.arch).to eq(nil)
    end

    it 'should return arch from binary rpm (i686)' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
      expect(rpm.arch).to eq('i686')
    end

    it 'should return arch from binary rpm (x86_64)' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.x86_64.rpm', false)
      expect(rpm.arch).to eq('x86_64')
    end

    it 'should return arch from binary rpm (armv7hl)' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.armv7hl.rpm', false)
      expect(rpm.arch).to eq('armv7hl')
    end

    it 'should return arch from binary rpm (noarch)' do
      rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
      expect(rpm.arch).to eq('noarch')
    end
  end

  describe 'BUILDHOST tag' do
    it 'should return buildhost from source rpm' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
      expect(rpm.buildhost).to eq('arm04-builder07.arm.fedoraproject.org')
    end

    it 'should return buildhost from binary rpm' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
      expect(rpm.buildhost).to eq('buildvm-05.phx2.fedoraproject.org')
    end
  end

  it 'should return buildtime from rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.buildtime).to eq(Time.parse('2014-04-01 23:38:32 +0300'))
  end

  it 'should return buildtime as instance of Time' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.buildtime).to be_an_instance_of(Time)
  end

  it 'should return changelogname from rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.changelogname).to eq('Pavel Raiskup <praiskup@redhat.com> - 1.26-31')
  end

  it 'should return changelogtext from rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.changelogtext).to eq("- document --exclude mistakes (#903666)\n- fix default ACLs propagation (#1082603)\n- infinite loop(s) in sparse-file handling (#1082608)\n- fix listing (and --verify) for big sparse files (#916995)\n- fix --list & --verify segfault (#986895)")
  end

  it 'should return changelogtime from rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.changelogtime).to eq(Time.parse('2014-04-01 15:00:00 +0300'))
  end

  it 'should return changelogtime as instance of Time' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.changelogtime).to be_an_instance_of(Time)
  end

  it 'should return package description from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.description.split("\n")[0]).to eq('The GNU tar program saves many files together in one archive and can')
  end

  it 'should return package description from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.description.split("\n")[0]).to eq('The GNU tar program saves many files together in one archive and can')
  end

  it 'should return package distribution from rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.distribution).to eq('Fedora Project')
  end

  pending 'should return package evr (epoch:version-release) from rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.evr).to eq('2:1.26-31.fc20')
  end

  pending 'should return package evr (epoch:version-release) from rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
    expect(rpm.evr).to eq('2014f-1.fc20')
  end

  pending 'should return package nevr (name-epoch:version-release) from source rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.nevr).to eq('tar-2:1.26-31.fc20')
  end

  pending 'should return package nevr (name-epoch:version-release) from binary rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.nevr).to eq('tar-2:1.26-31.fc20')
  end

  pending 'should return package nevr (name-epoch:version-release) from source rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
    expect(rpm.nevr).to eq('tzdata-2014f-1.fc20')
  end

  pending 'should return package nevr (name-epoch:version-release) from binary rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
    expect(rpm.nevr).to eq('tzdata-2014f-1.fc20')
  end

  it 'should return package nevra (name-epoch:version-release.arch) as nil from source rpm (source rpm doesn\'t have arch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.nevra).to eq(nil)
  end

  pending 'should return package nevra (name-epoch:version-release.arch) from binary rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.nevra).to eq('tar-2:1.26-31.fc20.i686')
  end

  pending 'should return package nevra (name-epoch:version-release) from binary rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
    expect(rpm.nevra).to eq('tzdata-2014f-1.fc20.noarch')
  end

  pending 'should return package nvr (name-version-release) from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.nvr).to eq('tar-1.26-31.fc20')
  end

  pending 'should return package nvr (name-version-release) from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.nvr).to eq('tar-1.26-31.fc20')
  end

  pending "should return package nvra (name-version-release.arch) as nil from source rpm (source rpm doesn't have arch)" do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.nvra).to eq(nil)
  end

  pending 'should return package nvra (name-version-release.arch) from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.nvra).to eq('tar-1.26-31.fc20.i686')
  end

  it 'should return package optflags as nil from source rpm (source rpm doesn\'t have optflags)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.optflags).to eq(nil)
  end

  it 'should return package optflags from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.optflags).to eq('-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches  -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables')
  end

  it 'should return package packager from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.packager).to eq('Fedora Project')
  end

  it 'should return package packager from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.packager).to eq('Fedora Project')
  end

  it 'should return package platform from source rpm as nil (source rpm doesn\'t have platform)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.platform).to eq(nil)
  end

  it 'should return package platform from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.platform).to eq('i686-redhat-linux-gnu')
  end

  it 'should return package sourcerpm from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.sourcerpm).to eq(nil)
  end

  it 'should return package sourcerpm from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.sourcerpm).to eq('tar-1.26-31.fc20.src.rpm')
  end

  it 'should return package url from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.url).to eq('http://www.gnu.org/software/tar/')
  end

  it 'should return package url from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.url).to eq('http://www.gnu.org/software/tar/')
  end

  it 'should return package url as nil from source rpm if url is empty' do
    rpm = RPM::File.new('./spec/data/basesystem-10.0-9.fc20.src.rpm', true)
    expect(rpm.url).to eq(nil)
  end

  it 'should return package url as nil from binary rpm if url is empty' do
    rpm = RPM::File.new('./spec/data/basesystem-10.0-9.fc20.noarch.rpm', false)
    expect(rpm.url).to eq(nil)
  end

  it 'should return package vendor from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.vendor).to eq('Fedora Project')
  end

  it 'should return package vendor from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.vendor).to eq('Fedora Project')
  end

  # TODO: maybe #serial can be dropped
  it 'should return package serial from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.serial).to eq(nil)
  end

  # TODO: maybe #serial can be dropped
  it 'should return package serial from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.serial).to eq(nil)
  end

  it 'should return package filename for source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.filename).to eq('tar-1.26-31.fc20.src.rpm')
  end

  it 'should return package filename for binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.filename).to eq('tar-1.26-31.fc20.i686.rpm')
  end

  it 'should return file md5 sum of rpm file' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.md5).to eq('7b7d2a5d2d404861647420218d854243')
  end

  it 'should return file size of rpm file' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.filesize).to eq(1_914_673)
  end

  it 'should read any single tag from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.read_tag('NAME')).to eq('tar')
  end

  pending 'it should fix empty readed tag with nil'
  pending 'it should fix "(none)" from rpm to empty string'
  pending 'read_array(queryformat)'
  pending 'read_raw(queryformat)'
  pending 'fileflags_with_filenames'

  it 'should return spec file name from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.specfilename).to eq('tar.spec')
  end

  it 'should return nil for spec file name from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.specfilename).to eq(nil)
  end

  it 'should extract spec file from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.specfile.split("\n")[0]).to eq('%if %{?WITH_SELINUX:0}%{!?WITH_SELINUX:1}')
  end

  it 'should return nil for spec file content from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.specfile).to eq(nil)
  end

  pending 'extract_file(filename)'

  it 'should return build requires for source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.build_requires).to eq([{ name: 'autoconf', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'automake', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'texinfo', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'gettext', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'libacl-devel', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'rsh', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'attr', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'acl', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'policycoreutils', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'libselinux-devel', deptype: 'manual', depflags: nil, version: nil },
                                      { name: 'rpmlib(FileDigests)', deptype: 'rpmlib', depflags: '<=', version: '4.6.0-1' },
                                      { name: 'rpmlib(CompressedFileNames)', deptype: 'rpmlib', depflags: '<=', version: '3.0.4-1' }])
  end

  it 'should return nil for build requires from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.build_requires).to eq(nil)
  end

  it 'should return nil for provides from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.provides).to eq(nil)
  end

  it 'should return provides from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.provides).to eq([{ name: '/bin/gtar', deptype: 'manual', depflags: nil, version: nil },
                                { name: '/bin/tar', deptype: 'manual', depflags: nil, version: nil },
                                { name: 'bundled(gnulib)', deptype: 'manual', depflags: nil, version: nil },
                                { name: 'tar', deptype: 'manual', depflags: '=', version: '2:1.26-31.fc20' },
                                { name: 'tar(x86-32)', deptype: 'manual', depflags: '=', version: '2:1.26-31.fc20' }])
  end

  it 'should return nil for short version of provides (p()) for source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.p).to eq(nil)
  end

  it 'should return short version provides (p()) from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.p).to eq(['/bin/gtar', '/bin/tar', 'bundled(gnulib)', 'tar', 'tar(x86-32)'])
  end

  it 'should return nil for requires from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.requires).to eq(nil)
  end

  it 'should return requires from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.requires).to eq([{ name: '/bin/sh', deptype: 'post,interp', depflags: nil, version: nil },
                                { name: '/bin/sh', deptype: 'preun,interp', depflags: nil, version: nil },
                                { name: '/sbin/install-info', deptype: 'post', depflags: nil, version: nil },
                                { name: '/sbin/install-info', deptype: 'preun', depflags: nil, version: nil },
                                { name: 'libacl.so.1', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libacl.so.1(ACL_1.0)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.0)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.1)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.1.1)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.17)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.2)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.2.3)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.3)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.3.4)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.4)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.6)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.7)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libc.so.6(GLIBC_2.8)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'libselinux.so.1', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'rpmlib(CompressedFileNames)', deptype: 'rpmlib', depflags: '<=', version: '3.0.4-1' },
                                { name: 'rpmlib(FileDigests)', deptype: 'rpmlib', depflags: '<=', version: '4.6.0-1'},
                                { name: 'rpmlib(PayloadFilesHavePrefix)', deptype: 'rpmlib', depflags: '<=', version: '4.0-1' },
                                { name: 'rtld(GNU_HASH)', deptype: 'auto', depflags: nil, version: nil },
                                { name: 'rpmlib(PayloadIsXz)', deptype: 'rpmlib', depflags: '<=', version: '5.2-1' }])
  end

  it 'should return nil for conflicts from source rpm' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
    expect(rpm.conflicts).to eq(nil)
  end

  it 'should return conflicts from binary rpm' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
    expect(rpm.conflicts).to eq([{ name: 'glibc-common', deptype: 'manual', depflags: '<=', version: '2.3.2-63' }])
  end

  it 'should return nil for short version of conflicts (c()) for source rpm' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
    expect(rpm.c).to eq(nil)
  end

  it 'should return short version conflicts (c()) from binary rpm' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
    expect(rpm.c).to eq(['glibc-common'])
  end

  it 'should return nil for obsoletes from source rpm' do
    rpm = RPM::File.new('./spec/data/iptraf-ng-1.1.4-7.fc20.src.rpm', true)
    expect(rpm.obsoletes).to eq(nil)
  end

  it 'should return obsoletes from binary rpm' do
    rpm = RPM::File.new('./spec/data/iptraf-ng-1.1.4-7.fc20.i686.rpm', false)
    expect(rpm.obsoletes).to eq([{ name: 'iptraf', deptype: 'manual', depflags: '<', version: '3.1' }])
  end

  it 'should return nil for short version of obsoletes (o()) for source rpm' do
    rpm = RPM::File.new('./spec/data/iptraf-ng-1.1.4-7.fc20.src.rpm', true)
    expect(rpm.o).to eq(nil)
  end

  it 'should return short version obsoletes (o()) from binary rpm' do
    rpm = RPM::File.new('./spec/data/iptraf-ng-1.1.4-7.fc20.i686.rpm', false)
    expect(rpm.o).to eq(['iptraf'])
  end

  pending 'changelogs'
  pending 'self.check_md5(file)'
=end
end
