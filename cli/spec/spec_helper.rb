require 'client_config'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups


  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # config.profile_examples = 3
  config.order = :random
end



if File.exists?(ClientConfig::CONFIG_PATH)
  abort "Mate, don't run the tests against an actual environment! Bad news for you!" unless ClientConfig.new.host == ClientConfig::LOCALHOST_SERVER
end
