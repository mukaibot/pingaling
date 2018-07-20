libpath = File.expand_path(File.join(__dir__, '..' , 'lib'))
$LOAD_PATH << libpath
require 'dotenv'
require 'ostruct'
require 'database'
require 'rspec'

Dotenv.load('.env.test')

Dir.glob(File.join(libpath, '*.rb')).each { |f| require f }
# Dir.glob(File.join(libpath, 'repositories', '*.rb')).each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.example_status_persistence_file_path = "spec/examples.txt"
  # config.profile_examples = 5
  config.order = :random
  Kernel.srand config.seed
end
