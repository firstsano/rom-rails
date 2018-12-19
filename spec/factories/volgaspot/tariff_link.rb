FactoryBot.define do
  factory :volgaspot_tariff_link, class: Hash do
    skip_create

    id { generate(:random_id) }
    tariff_id { generate(:random_id) }
    discount_period_id { generate(:random_id) }
    link_date { Faker::Time.backward(14).to_i }

    initialize_with { attributes }
  end
end
