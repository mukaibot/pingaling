require 'spec_helper'
require_relative '../support/shell_matcher'

RSpec.describe "ZSH Completion" do
  it 'must have all root commands' do
    expect(all_pingaling_commands).to eq completion_root_commands
  end

  it 'has options for sub-commands' do
    aggregate_failures do
      all_pingaling_commands.each do |command|
        pingaling_command(command).each do |subcommand|
          expect(command).to have_completion_option_for(subcommand)
        end
      end
    end
  end

  private

  def all_pingaling_commands
    pingaling_command
  end

  def specific_pingaling_command(cmd)
    pingaling_command(cmd)
  end

  def completion_root_commands
    output  = `bin/pingaling completion | grep '"1: '`.chomp
    matches = %r{\(([\w\s]+)\)}.match(output)

    matches[1].split(' ').sort
  end

  def pingaling_command(command = '')
    selecting_commands = false
    commands           = []
    output             = `bin/pingaling #{command} --help`.chomp.split("\n")
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
      .map { |c| c.split(", ").first }
      .sort
  end
end
