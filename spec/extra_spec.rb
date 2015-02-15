require 'spec_helper'
require 'rpmfile'

describe 'RPM::File Extra stuff' do
  context 'EVR' do
    it 'should return package evr (epoch:version-release) from rpm (with epoch)' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
      expect(rpm.evr).to eq('2:1.26-31.fc20')
    end

    it 'should return package evr (epoch:version-release) from rpm (without epoch)' do
      rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.src.rpm', true)
      expect(rpm.evr).to eq('2014f-1.fc20')
    end
  end

  context 'NEVR' do
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
  end

  context 'NEVRA' do
    it 'should return package nevra (name-epoch:version-release.arch) as nil from source rpm (source rpm doesn\'t have arch)' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
      expect(rpm.nevra).to eq(nil)
    end

    it 'should return package nevra (name-epoch:version-release.arch) from binary rpm (with epoch)' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
      expect(rpm.nevra).to eq('tar-2:1.26-31.fc20.i686')
    end

    it 'should return package nevra (name-epoch:version-release) from binary rpm (without epoch)' do
      rpm = RPM::File.new('./spec/data/tzdata-2014f-1.fc20.noarch.rpm', false)
      expect(rpm.nevra).to eq('tzdata-2014f-1.fc20.noarch')
    end
  end

  context 'NVR' do
    it 'should return package nvr (name-version-release) from source rpm' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
      expect(rpm.nvr).to eq('tar-1.26-31.fc20')
    end

    it 'should return package nvr (name-version-release) from binary rpm' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
      expect(rpm.nvr).to eq('tar-1.26-31.fc20')
    end
  end

  context 'NVRA' do
    it "should return package nvra (name-version-release.arch) as nil from source rpm (source rpm doesn't have arch)" do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
      expect(rpm.nvra).to eq(nil)
    end

    it 'should return package nvra (name-version-release.arch) from binary rpm' do
      rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
      expect(rpm.nvra).to eq('tar-1.26-31.fc20.i686')
    end
  end
end
