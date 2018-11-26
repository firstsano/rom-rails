class UserSessionRepository < ROM::Repository::Root
  root :user_sessions

  struct_namespace Rapi::Entities

  def login(login:, password:)
    user_sessions.command(:login).call login, password
  end
end
