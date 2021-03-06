class UserRepository < ROM::Repository::Root
  root :users

  # Though it's not necessary for current version of
  # rom-http, the behaviour will change in future, and
  # it's better to use `auto_struct false` now
  auto_struct false
  struct_namespace Rapi::Entities

  def user_by_id(id)
    users.by_id(id).one
  end

  private

  def users
    super.map_with(:users_mapper)
  end
end
