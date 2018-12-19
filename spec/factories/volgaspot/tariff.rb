FactoryBot.define do
  factory :volgaspot_tariff, class: Hash do
    skip_create

    id { generate(:random_id) }
    active_tariff_link { nil }
    services { nil }

    trait :with_active_tariff do
      association :active_tariff_link, factory: :volgaspot_tariff_link
    end

    # Service links from volgaspot are returned as hash
    # with service_link_id as keys
    trait :with_services do
      transient do
        services_count { 5 }
      end

      after(:create) do |volgaspot_tariff, evaluator|
        services = create_list(:volgaspot_service_link, evaluator.services_count)
        grouped_services = services.group_by { |service| service[:service_link_id] }
        volgaspot_tariff[:services] = grouped_services
      end
    end

    trait :complete do
      with_active_tariff
      with_services
    end

    initialize_with { attributes }
  end
end
