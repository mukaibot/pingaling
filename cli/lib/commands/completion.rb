require 'commands/base'

module Commands
  class Completion < Base
    ROOT = File.expand_path(File.join(__dir__, "..", ".."))
    ZSH_PATH = File.expand_path(File.join(ROOT, "doc", "_pingaling"))

    def execute
      puts File.read(ZSH_PATH)
    end
  end
end
