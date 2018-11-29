class UserRepository < ROM::Repository::Root
  root :users

  struct_namespace Rapi::Entities

  def by_id(id)
    users.with_account_details.by_id(id).one
  end

  def all
    users.all
  end

  private

  def users
    super.map_with(:users_mapper)
  end
end
