require_relative 'lib/sas_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'sas_test_kit'
  spec.version       = SasTestKit::VERSION
  spec.authors       = ["mpriour"]
  # spec.email         = ['TODO']
  spec.date          = Time.now.utc.strftime('%Y-%m-%d')
  spec.summary       = 'Sas Test Kit'
  # spec.description   = <<~DESCRIPTION
  #   This is a big markdown description of the test kit.
  # DESCRIPTION
  # spec.homepage      = 'TODO'
  spec.license       = 'Apache-2.0'
  spec.add_runtime_dependency 'inferno_core', '~> 0.5.4'
  spec.add_development_dependency 'database_cleaner-sequel', '~> 1.8'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.1.2')
  spec.metadata['inferno_test_kit'] = 'true'
  # spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = 'TODO'
  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['lib/**/*.json'],
    Dir['config/presets/*.json'],
    Dir['config/presets/*.json.erb'],
    'LICENSE'
  ].flatten

  spec.require_paths = ['lib']
end
