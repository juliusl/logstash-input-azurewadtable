Gem::Specification.new do |s|
  s.name = 'logstash-input-azurewadtable'
  s.version         = '0.9.5'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This plugin will collect Microsoft Azure Diagnostics data from Azure Storage."
  s.description = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["Microsoft Corporation"]
  s.email = 'juliusl@microsoft.com'
  s.homepage = "https://github.com/Azure/azure-diagnostics-tools"
  s.require_paths = ["lib"]

  # Files
  s.files = `git ls-files`.split($\)
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "input" }

  # Gem dependencies
  s.add_runtime_dependency 'logstash-core', '>= 1.4.0'
  s.add_runtime_dependency 'azure', '~> 0.7.3'
  s.add_development_dependency 'logstash-devutils', '~> 0.0.14'
end
