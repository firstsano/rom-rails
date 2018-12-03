module Volgaspot
  class UserRepository < ROM::Repository::Root
    root :volgaspot_users

    # Though it's not necessary for current version of
    # rom-http, a behaviour will change in future, and
    # it's better to use `auto_struct false` now
    auto_struct false
    struct_namespace Rapi::Entities

    def find(id)
      volgaspot_users.by_id(id).one
    end

    private

    def volgaspot_users
      super.map_with(:volgaspot_users_mapper)
    end
  end
end