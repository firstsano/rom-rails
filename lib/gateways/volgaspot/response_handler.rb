require 'json'


class ResponseHandler
  def call(response, dataset)
    if %i(post put patch).include?(dataset.request_method)
      JSON.parse(response.body, symbolize_names: true)
    else
      Array([JSON.parse(response.body, symbolize_names: true)]).flatten
    end
  end
end