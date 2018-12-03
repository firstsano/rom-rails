module Volgaspot
  class UsersMapper < ROM::Mapper
    relation :volgaspot_users

    register_as :volgaspot_users_mapper

    reject_keys true

    unwrap :account do
      # TODO: change flag to message describing type
      # of block or add block_type attribute
      attribute(:is_blocked, &:positive?)
      attribute :credit
      attribute(:balance) { |b| b.round(2) }
      attribute :is_internet_on, from: :int_status
      attribute :is_unlimited, from: :unlimited
      attribute :utm_account, from: :id
    end

    unwrap :account_details do
      attribute :days_left, from: :work_days_left
    end

    # It's important for 'id' attribute to be AFTER
    # unwrapping 'id' from 'account'. Otherwise it
    # removes current 'id' with 'utm_account'.
    attribute :id
    attribute :login
    attribute :name, from: :full_name
    attribute :address, from: :actual_address
    attribute :phone, from: :mobile_phone
    attribute :email
    attribute :vist_account, from: :account_id
  end
end
