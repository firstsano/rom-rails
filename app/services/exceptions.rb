module Exceptions
  class UserNotFound < StandardError; end

  module RemoteServer
    class RequestError < StandardError; end
    class RequestUnsuccessful < StandardError; end
  end
end
