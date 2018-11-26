class UsersMapper < ROM::Mapper
  relation :users

  register_as :users_mapper

  attribute :id
  attribute :login
  attribute :name, from: :full_name
  attribute :address, from: :actual_address
  attribute :phone, from: :mobile_phone
  attribute :status
  attribute :email
  attribute :account_id
end
