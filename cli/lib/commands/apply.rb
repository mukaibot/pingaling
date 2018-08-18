require 'commands/base'
require 'yaml'

module Commands
  class Apply < Base
    option ['-f', '--file'], 'FILE', 'Path to the yaml file', attribute_name: :manifest, required: true do |arg|
      validate_file(arg)
    end

    def execute
      response = Gateway.new.post_manifest(manifest)
      if response.code.between?(200, 201)
        success(response)
      else
        failure(response)
      end
    end

    private

    def failure(response)
      puts 'Manifest couldn\'t be applied.'
      puts response.body
      exit 1
    end

    def success(response)
      puts response.body
    end

    def validate_file(path)
      if File.exist?(path)
        begin
          manifest = YAML.load_file(path)
          manifest.fetch('apiVersion')
        rescue
          raise(ArgumentError, "'#{path}' is not a valid file")
        end

        manifest
      else
        raise(ArgumentError, "'#{path}' does not exist")
      end
    end
  end
end
