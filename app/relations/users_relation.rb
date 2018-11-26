class UsersRelation < ::ROM::Relation[:http]
  gateway :volgaspot

  schema(:users) do
    attribute :id, Types::Strict::Int
    attribute :login, Types::Strict::String
    attribute :full_name, Types::Strict::String
    attribute :actual_address, Types::Strict::String
    attribute :mobile_phone, Types::Strict::String
    attribute :email, Types::Strict::String
    attribute :status, Types::Strict::String
    attribute :account_id, Types::Strict::Int
  end

  def by_id(id)
    with_path(id.to_s)
  end
end
