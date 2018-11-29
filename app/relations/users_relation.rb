class UsersRelation < ::ROM::Relation[:http]
  gateway :volgaspot

  schema(:users) do
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
    ).optional
    attribute :account, Types::Hash.schema(
        is_blocked: Types::Int,
        credit: Types::Int,
        balance: Types::Float,
        int_status: Types::Form::Bool,
        unlimited: Types::Form::Bool,
        id: Types::Int,
    ).optional

    primary_key :id
  end

  def by_id(id)
    with_path(id.to_s)
  end

  def with_account_details
    add_params(expand: 'account,account_details')
  end
end
