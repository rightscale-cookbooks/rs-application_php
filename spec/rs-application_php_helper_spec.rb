require_relative '../libraries/helper'

describe RsApplicationPhp::Helper do
  describe '#split_by_package_name_and_version' do
    it 'returns packages as an array if the input does not have any package with version numbers' do
      packages = ['pkg1', 'pkg2']
      versionized_packages = RsApplicationPhp::Helper.split_by_package_name_and_version(packages)
      versionized_packages.should be_a(Array)
      versionized_packages.should == packages
    end

    it 'returns the packages as a Hash if package versions are specified' do
      packages = ['pkg1=1.0', 'pkg2=2.0']
      versionized_packages = RsApplicationPhp::Helper.split_by_package_name_and_version(packages)
      versionized_packages.should be_a(Hash)
      versionized_packages.should == {'pkg1' => '1.0', 'pkg2' => '2.0'}
    end

    it 'returns the packages as a Hash even if only one package has version number specified' do
      packages = ['pkg1', 'pkg2=2.0']
      versionized_packages = RsApplicationPhp::Helper.split_by_package_name_and_version(packages)
      versionized_packages.should be_a(Hash)
      versionized_packages.should == {'pkg1' => nil, 'pkg2' => '2.0'}
    end

    it 'does not throw an error if the input is empty' do
      expect(
        lambda { RsApplicationPhp::Helper.split_by_package_name_and_version([]) }
      ).not_to raise_error
    end
  end

  describe '#validate_application_name' do
    it 'returns true if the application name is valid' do
      ['example', '123test', '_api'].each do |name|
        RsApplicationPhp::Helper.validate_application_name(name).should be_true
      end
    end

    it 'raises an exception if application name is invalid' do
      ['/example', '$%^&*#'].each do |name|
        expect { RsApplicationPhp::Helper.validate_application_name(name) }.to raise_error(RuntimeError)
      end
    end
  end
end
