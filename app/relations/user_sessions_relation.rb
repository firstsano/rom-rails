class UserSessionsRelation < ::ROM::Relation[:http]
  gateway :volgaspot

  schema(:user_sessions) do
    attribute :id, Types::Strict::Int
    attribute :login, Types::Strict::String
  end
end
