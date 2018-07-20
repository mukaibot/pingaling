class CheckResult
  def initialize(success:, message: nil)
    @success = success
    @message = message
  end

  def success?
    @success
  end
end
