class UserRepository < ROM::Repository::Root
  root :volgaspot_users

  # Though it's not necessary for current version of
  # rom-http, a behaviour will change in future, and
  # it's better to use `auto_struct false` now
  auto_struct false
  struct_namespace Rapi::Entities

  def user_by_id(id)
    volgaspot_users.by_id(id).map_to(OpenStruct).one
  end

  private

  def volgaspot_users
    super.map_with(:volgaspot_users_mapper)
  end
end
