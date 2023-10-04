FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número #{n}" }
    # association :customer, factory: customer # Sobrescreve a factory, caso seja necessário, mas caso contrário é a mesma coisa que deixar somente customer
    customer
  end
end