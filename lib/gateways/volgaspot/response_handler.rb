require 'json'

class ResponseHandler
  def call(response, _dataset)
    parsed_response = parse_response response
    raise ::Exceptions::RemoteServer::RequestUnsuccessful, $ERROR_INFO unless parsed_response[:success]

    setup_response parsed_response[:data]
  end

  private

  def parse_response(response)
    raise ::Exceptions::RemoteServer::RequestError, $ERROR_INFO unless response&.body

    JSON.parse(response.body, symbolize_names: true)
  end

  # Process edge cases:
  #   1. Returned data is a hash with keys as service ids,
  #      which can't be processed automatically by mapper
  def setup_response(response)
    response = response.values if is_unprocessable_hash?(response)
    Array([response]).flatten
  end

  def is_unprocessable_hash?(hash)
    return false unless hash.is_a?(Hash)

    hash.keys.map { |key| Integer(key.to_s) }
    true
  rescue
    false
  end
end
