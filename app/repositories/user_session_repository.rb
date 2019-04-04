class UserSessionRepository < ROM::Repository::Root
  root :user_sessions

  auto_struct false
  struct_namespace Rapi::Entities

  def login(login:, password:)
    response = user_sessions.command(:login).call login, password
    OpenStruct.new response
  end
end
