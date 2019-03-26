FactoryBot.define do
  factory :volgaspot_payment, class: Hash do
    skip_create

    id { SecureRandom.uuid }
    status { Faker::Lorem.word }
    paid { Faker::Boolean.boolean }
    test { Faker::Boolean.boolean }

    amount do
      {
        value: Faker::Number.decimal(2),
        currency: "RUB"
      }
    end

    payment_method do
      {
        type: 'alfabank',
        id: generate(:random_id),
        saved: Faker::Boolean.boolean,
        title: Faker::Lorem.word,
        login: Faker::Lorem.word
      }
    end

    created_at { Time.now.iso8601 }

    trait :with_bank_card_method do
      payment_method do
        month = sprintf '%.2d', Faker::Number.within(1..12)
        year = Faker::Date.between(20.years.ago, Date.today).year
        {
          type: 'bank_card',
          id: generate(:random_id),
          saved: Faker::Boolean.boolean,
          card: {
            first6: Faker::Number.number(6),
            last4: Faker::Number.number(4),
            expiry_year: year,
            expiry_month: month,
            card_type: Faker::Lorem.word
          }
        }
      end
    end

    initialize_with { attributes }
  end
end
