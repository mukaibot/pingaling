require 'commands/apply'
require 'commands/completion'
require 'commands/config'
require 'commands/delete_resource'
require 'commands/get_resource'

module Commands
  class MainCommand < Base
    subcommand ['apply'], 'Create/update a resource', Commands::Apply
    subcommand ['get'], 'Gets a resource', Commands::GetResource
    subcommand ['config'], 'Modify client config', Commands::ClientConfig
    subcommand ['delete'], 'Delete resources by name', Commands::DeleteResource
    subcommand ['completion'], 'Output ZSH shell completion', Commands::Completion

    option ['-v', '--version'], :flag, "Show version" do
      from_root = File.expand_path(File.join(__dir__, "..", "..", "..", "version.txt"))
      copied_to_cli = File.expand_path(File.join(__dir__, "..", "..", "version.txt"))
      puts File.read(File.exists?(from_root) ? from_root : copied_to_cli).chomp
      exit(0)
    end

    def run(*args)
      super(*args)
    end
  end
end
