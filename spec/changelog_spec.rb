require 'spec_helper'
require 'rpmfile'

describe 'RPM::File Changelog stuff' do
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
end
