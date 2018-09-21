# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :have_completion_option_for do |expected|
  match do |verb|
    completion_function(verb).include?(expected)
  end

  failure_message do |verb|
    "expected shell completion for command '#{verb}' to contain completion option for '#{expected}'"
  end

  def completion_function(input)
    name         = "function _pingaling_#{input}"
    output       = `bin/pingaling completion`.chomp.split("\n")
    function_def = []
    in_function  = false
    completed    = false

    output.each do |line|
      if line.include?(name)
        in_function = true
        next
      end

      if in_function && line.strip == '}'
        completed   = true
        in_function = false
      end

      function_def << line.strip if in_function && !completed
    end

    function_def.join("\n")
  end
end
