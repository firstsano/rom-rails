class UserSessionsMapper < ROM::Mapper
  relation :user_sessions

  model UserSession

  register_as :user_sessions_mapper

  attribute :id
  attribute :login
  attribute :name, from: :full_name
  attribute :address, from: :actual_address
  attribute :phone, from: :mobile_phone
  attribute :email
  attribute :account_id
end
