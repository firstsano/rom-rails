class UserSession
  extend Dry::Initializer

  attr_accessor :id, :login, :account, :vist_account

  option :session_repo, default: proc { UserSessionRepository.new(ROM.env) }
  option :user_repo, default: proc { UserRepository.new(ROM.env) }

  def initialize(login:, **options)
    super
    @login = login
    @id = options[:id]
    @account = options[:account]
    @vist_account = options[:vist_account]
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

    new(login: login)
  end

  # Authenticates user
  def authenticate(password)
    user_data = session_repo.login login: login, password: password
    return false unless user_data

    @id = user_data.id
    @account = user_data.utm_account
    @vist_account = user_data.account_id
  end

  def to_token_payload
    {
      user: {
        id: id,
        login: login,
        account: account,
        vist_account: vist_account
      }
    }
  end

  def self.from_token_payload(payload)
    credentials = payload['user'].symbolize_keys
    new(**credentials)
  end
end
