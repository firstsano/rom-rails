module Exceptions
  class UserNotFound < StandardError; end

  module RemoteServer
    module Request
      class Error < StandardError; end
      class Unsuccessful < StandardError; end
      class NotFound < StandardError; end
      class Unauthorized < StandardError; end
    end
  end

  module ExceptionsHandler
    def self.included(klass)
      klass.class_eval do
        rescue_from ::Exceptions::RemoteServer::Request::Unsuccessful, with: :request_unsuccessful
      end
    end

    private

    def request_unsuccessful(exception)
      render json: { description: exception.message },
             status: :internal_server_error
    end
  end
end
