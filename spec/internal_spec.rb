require 'spec_helper'
require 'rpmfile'

describe 'RPM::File Internal stuff' do
  it 'should read any single tag from source rpm' do
    rpm = RPM::File.new('./spec/data/tar-1.26-31.fc20.src.rpm', true)
    expect(rpm.read_tag('NAME')).to eq('tar')
  end
end
