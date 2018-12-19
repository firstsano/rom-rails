FactoryBot.define do
  factory :volgaspot_service_link, class: Hash do
    skip_create

    id { generate(:random_id) }
    service_id { generate(:random_id) }
    service_type { Faker::Number.number(1) }
    service_name { Faker::Lorem.sentence }
    tariff_name { Faker::Lorem.sentence }
    service_cost { Faker::Number.decimal(2, 3) }
    service_link_id { generate(:random_id) }
    discount_period_id { generate(:random_id) }

    initialize_with { attributes }
  end
end
