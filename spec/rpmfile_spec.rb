require 'spec_helper'
require 'rpmfile'

describe 'RPM::File' do
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

  it 'should return buildhost from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.buildhost).to eq('arm04-builder07.arm.fedoraproject.org')
  end

  it 'should return buildhost from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.buildhost).to eq('buildvm-05.phx2.fedoraproject.org')
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

  it 'should return package epoch from rpm (e() -> alias for epoch())' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.e).to eq(2)
  end

  it 'should return package epoch from rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.epoch).to eq(2)
  end

  it 'should return package epoch as Fixnum from rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.epoch).to be_an_instance_of(Fixnum)
  end

  it 'should return package epoch as nil if epoch is empty' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
    expect(rpm.epoch).to eq(nil)
  end

  it 'should return package evr (epoch:version-release) from rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.evr).to eq('2:1.26-31.fc20')
  end

  it 'should return package evr (epoch:version-release) from rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
    expect(rpm.evr).to eq('2014f-1.fc20')
  end

  it 'should return package group from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.group).to eq('Applications/Archiving')
  end

  it 'should return package group from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.group).to eq('Applications/Archiving')
  end

  it 'should return package license from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.license).to eq('GPLv3+')
  end

  it 'should return package license from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.license).to eq('GPLv3+')
  end

  it 'should return package name from source rpm (n() -> alias for name())' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.n).to eq('tar')
  end

  it 'should return package name from binary rpm (n() -> alias for name())' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.n).to eq('tar')
  end

  it 'should return package name from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.name).to eq('tar')
  end

  it 'should return package name from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.name).to eq('tar')
  end

  it 'should return package nevr (name-epoch:version-release) from source rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.nevr).to eq('tar-2:1.26-31.fc20')
  end

  it 'should return package nevr (name-epoch:version-release) from binary rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.nevr).to eq('tar-2:1.26-31.fc20')
  end

  it 'should return package nevr (name-epoch:version-release) from source rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
    expect(rpm.nevr).to eq('tzdata-2014f-1.fc20')
  end

  it 'should return package nevr (name-epoch:version-release) from binary rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
    expect(rpm.nevr).to eq('tzdata-2014f-1.fc20')
  end

  it 'should return package nevra as nil from source rpm (source rpm doesn\'t have arch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.nevra).to eq(nil)
  end

  it 'should return package nevra (name-epoch:version-release) from binary rpm (with epoch)' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.nevra).to eq('tar-2:1.26-31.fc20.i686')
  end

  it 'should return package nevra (name-epoch:version-release) from binary rpm (without epoch)' do
    rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
    expect(rpm.nevra).to eq('tzdata-2014f-1.fc20.noarch')
  end

  it 'should return package nvr (name-version-release) from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.nvr).to eq('tar-1.26-31.fc20')
  end

  it 'should return package nvr (name-version-release) from binary rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
    expect(rpm.nvr).to eq('tar-1.26-31.fc20')
  end


  # it 'should read tag from any rpm' do
  #   rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
  #   expect(rpm.read_tag('ARCH')).to eq('i686')
  # end

  # tar-1.26-31.fc20.armv7hl.rpm
  # tar-1.26-31.fc20.i686.rpm
  # tar-1.26-31.fc20.src.rpm
  # tar-1.26-31.fc20.x86_64.rpm
  # tar-debuginfo-1.26-31.fc20.armv7hl.rpm
  # tar-debuginfo-1.26-31.fc20.i686.rpm
  # tar-debuginfo-1.26-31.fc20.x86_64.rpm
  #

  # it 'should return name from source rpm' do
  #   rpm = RPM::File.new('data/tar-1.26-31.fc20.src.rpm', true)
  #   expect(rpm.name).to eq('tar')
  # end

end