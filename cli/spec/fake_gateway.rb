# frozen_string_literal: true

require 'json'

class FakeGateway
  DOC_PATH = File.expand_path(File.join(__dir__, '..', '..', 'api', 'docs', 'api.md'))

  def initialize
    @api_docs = File.readlines(DOC_PATH)
  end

  def describe_endpoint(_)
    doc_response('api-api-endpoints-show')
  end

  def get_endpoint(_)
    doc_response('api-api-endpoints-show')
  end

  def delete_endpoint(_)
    doc_response('api-api-endpoints-delete').body
  end

  def get_health_summary
    doc_response('api-api-health-index')
  end

  def get_incidents
    doc_response('api-api-incidents-index')
  end

  def post_manifest(_)
    doc_response('api-api-manifest-apply')
  end

  private

  def doc_response(link_id)
    response         = []
    found_block      = false
    in_response_body = false
    completed        = false

    @api_docs.each do |line|
      found_block = true if line.include? "id=#{link_id}"

      if found_block && line.include?('```json')
        in_response_body = true
        next
      end

      if in_response_body && !completed
        if line.chomp == '```'
          completed        = true
          in_response_body = false
        else
          response << line.strip
        end
      end
    end

    OpenStruct.new(
      body:
        response
          .join
          .delete("\n")
    )
  end
end
