FactoryBot.define do
  factory :customer, aliases: [:user] do
    transient do
      upcase { false }
      qtt_orders { 3 }
    end

    name { Faker::Name.name }
    email { Faker::Internet.email }
    address { Faker::Address.street_address }

    # sequence(:email, 'a') { |n| "meu_email-#{n}@email.com" }

    trait :vip do
      vip { true }
      days_to_pay { 30 }
    end

    trait :default do
      vip { false }
      days_to_pay { 10 }
    end

    trait :male do
      gender { 'M' }
    end

    trait :female do
      gender { 'F' }
    end

    trait  :with_orders do
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.qtt_orders, customer: customer)
      end
    end

    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_default, traits: [:default]

    factory :customer_male_default, traits: [:default, :male]
    factory :customer_female_default, traits: [:default, :male]
    factory :customer_male_vip, traits: [:default, :male]
    factory :customer_female_vip, traits: [:default, :female]

    after(:create) do |customer, evaluator|
      customer.name.upcase if evaluator.upcase
    end
  end
end