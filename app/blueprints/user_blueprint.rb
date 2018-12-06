class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :id, :login, :name, :address, :phone, :email,
         :vist_account, :is_blocked, :credit, :balance, :is_internet_on,
         :is_unlimited, :utm_account, :days_left
end
