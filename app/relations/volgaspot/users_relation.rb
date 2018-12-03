module Volgaspot
  class UsersRelation < ::ROM::Relation[:http]
    gateway :volgaspot

    schema(:volgaspot_users) do
      attribute :id, Types::Int
      attribute :login, Types::Strict::String
      attribute :full_name, Types::Strict::String
      attribute :actual_address, Types::Strict::String
      attribute :mobile_phone, Types::String
      attribute :email, Types::String
      attribute :status, Types::String
      attribute :account_id, Types::Int
      attribute :account_details, Types::Hash.schema(
        work_days_left: Types::Strict::Int
      )
      attribute :account, Types::Hash.schema(
        is_blocked: Types::Int,
        credit: Types::Int,
        balance: Types::Float,
        int_status: Types::Form::Bool,
        unlimited: Types::Form::Bool,
        id: Types::Int
      )

      primary_key :id
    end

    def by_id(id)
      with_base_path('users')
        .add_params(expand: 'account,account_details')
        .with_path(id.to_s)
    end
  end
end
