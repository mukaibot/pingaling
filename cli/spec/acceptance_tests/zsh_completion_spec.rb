require 'spec_helper'

RSpec.describe "ZSH Completion" do
  it 'must have all root commands' do
    expect(root_commands).to eq %w(apply config delete get)
  end

  private

  def root_commands
    selecting_commands = false
    commands = []
    output = `bin/pingaling`.chomp.split("\n")
    output.each do |line|
      if line.strip.start_with?("Subcommands:")
        selecting_commands = true
        next
      end
      if selecting_commands
        commands << line.strip.split("  ").first
      end
      if line.strip == ""
        selecting_commands = false
      end
    end

    commands
      .compact
      .sort
  end
end
