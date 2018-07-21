class Endpoint
  class << self
    def rando_name
      [
        %w(widget dingbat fuzzball).sample,
        %w(api worker throbbler listener uploader checker).sample
      ].join('-')
    end

    def rando_path
      %w(/healthz /heartbeat /diagnostic/status/heartbeat).sample
    end

    def random
      {
        name: rando_name,
        status: %w(OK FAILED).sample,
        path: rando_path
      }
    end
  end
end
