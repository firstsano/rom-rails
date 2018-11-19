require 'json'


class ResponseHandler
  def call(response, dataset)
    parsed_response = parse_response response
    raise ::Exceptions::RemoteServer::RequestUnsuccessful, $! unless parsed_response[:success]
    parsed_response[:data]
  end

  def parse_response(response)
    raise ::Exceptions::RemoteServer::RequestError, $! unless response&.body
    JSON.parse(response.body, symbolize_names: true)
  end
end