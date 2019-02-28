module Gateways
  module YandexTill
    class RequestHandler < BaseRequestHandler
      param :username
      param :password

      private

      def authenticate(request)
        request.basic_auth username, password
      end
    end
  end
end
