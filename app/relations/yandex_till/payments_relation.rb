module YandexTill
  class PaymentsRelation < ::ROM::Relation[:http]
    gateway :yandex_till

    schema(:yandex_till_payments) do
      attribute :id, ::Types::Strict::String
      primary_key :id
    end

    def base
      with_base_path('payments')
    end
  end
end
