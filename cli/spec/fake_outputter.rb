class FakeOutputter
  attr_reader :messages

  def initialize
    @messages = []
  end

  def write(msg)
    messages << msg
    puts msg
  end
end
