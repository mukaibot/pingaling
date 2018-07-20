class ResultUpdater
  def call(id:, type:, check_result:)
    @id = id
    @type = type
    @check_result = check_result

    true
  end
end
