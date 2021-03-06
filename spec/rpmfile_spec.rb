require 'spec_helper'
require 'rpmfile'

describe 'RPM::File' do
  describe 'Basic tags' do

  end

=begin

  it 'should return package optflags as nil from source rpm (source rpm doesn\'t have optflags)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.optflags).to eq(nil)
  end

  it 'should return package optflags from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.optflags).to eq('-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches  -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables')
  end

  it 'should return package platform from source rpm as nil (source rpm doesn\'t have platform)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.platform).to eq(nil)
  end

  it 'should return package platform from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.platform).to eq('i686-redhat-linux-gnu')
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
