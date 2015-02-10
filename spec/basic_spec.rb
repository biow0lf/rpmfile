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

    context 'URL' do
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
    end

    context 'PACKAGER' do
      it 'should return package packager from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.packager).to eq('Fedora Project')
      end

      it 'should return package packager from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.packager).to eq('Fedora Project')
      end
    end

    context 'VENDOR' do
      it 'should return package vendor from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.vendor).to eq('Fedora Project')
      end

      it 'should return package vendor from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.vendor).to eq('Fedora Project')
      end
    end

    context 'DISTRIBUTION' do
      it 'should return package distribution from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.distribution).to eq('Fedora Project')
      end

      it 'should return package distribution from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', true)
        expect(rpm.distribution).to eq('Fedora Project')
      end
    end

    context 'DESCRIPTION' do
      it 'should return package description from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.description.split("\n")[0]).to start_with('The GNU tar')
      end

      it 'should return package description from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.description.split("\n")[0]).to start_with('The GNU tar')
      end
    end

    context 'ARCH' do
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

    context 'BUILDHOST' do
      it 'should return buildhost from source rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.buildhost).to eq('arm04-builder07.arm.fedoraproject.org')
      end

      it 'should return buildhost from binary rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.i686.rpm', false)
        expect(rpm.buildhost).to eq('buildvm-05.phx2.fedoraproject.org')
      end
    end

    context 'BUILDTIME' do
      it 'should return buildtime from rpm' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.buildtime).to eq(Time.parse('2014-04-01 23:38:32 +0300'))
      end

      it 'should return buildtime as instance of Time' do
        rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
        expect(rpm.buildtime).to be_an_instance_of(Time)
      end
    end

  end
end
