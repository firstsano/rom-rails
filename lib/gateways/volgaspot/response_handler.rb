require 'json'

class ResponseHandler
  include ::Exceptions::RemoteServer

  def call(response, dataset)
    guard_from_invalid_request response
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    if %i[post put patch].include?(dataset.request_method)
      setup_response parsed_response
    else
      raise RequestUnsuccessful, $ERROR_INFO unless parsed_response[:success]
      setup_response parsed_response[:data]
    end
  end

  private

  def guard_from_invalid_request(response)
    not_found_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_found]
    raise RequestNotFound, $ERROR_INFO if response.code.to_i == not_found_code
    raise RequestError, $ERROR_INFO unless response&.body
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
