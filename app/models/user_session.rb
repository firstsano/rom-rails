class UserSession
  extend Dry::Initializer

  attr_accessor :id, :login

  option :repo, default: proc { UserSessionRepository.new(ROM.env) }

  def initialize(login:, **options)
    super
    @id = options[:id]
    @login = login
  end

  # When asking to generate token we first
  # looking for instance of model with appropriate
  # attributes with User.from_token_request and then
  # we asking the instance it to authenticate with
  # UserSession#authenticate

  # Returns nil, Exception or UserSession instance
  def self.from_token_request(request)
    login = request.POST.dig 'auth', 'login'
    raise Knock.not_found_exception_class_name unless login
    self.new login: login
  end

  # Authenticates user
  def authenticate(password)
    user_session_data = repo.login login: login, password: password
    self.id = user_session_data.id
  end

  def to_token_payload
    {
        user: {
            id: id,
            login: login
        }
    }
  end

  def self.from_token_payload(payload)
    credentials = payload['user'].symbolize_keys
    self.new **credentials
  end
end