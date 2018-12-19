FactoryBot.define do
  sequence :random_id do
    Faker::Number.unique.between(1, 999_000)
  end
end