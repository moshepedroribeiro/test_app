require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '#full_name' do
    # customer = create(:user, name: 'Moshé')
    customer = build(:user, name: 'Moshé')
    puts customer.email
    expect(customer.full_name).to eq('Sr. Moshé')
  end

  it 'Usando o attributes_for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with('Sr')
  end

  it 'Atributo Transitório' do
    customer = create(:customer_default, upcase: false)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Cliente Masculino Vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
  end

  it 'Cliente Masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it 'has_many' do
    customer = create(:customer, :with_orders, qtt_orders: 4)
    puts customer.inspect
    puts customer.orders.inspect

    expect(customer.orders.count).to eq(4)
  end

  it 'travel_to' do
    travel_to Time.zone.local(2004, 11, 24, 01, 04, 44) do
      @customer = create(:customer_vip)
    end

    expect(@customer.created_at).to eq(Time.new(2004, 11, 24, 01, 04, 44))
  end

  it { expect{create(:customer)}.to change{Customer.all.size}.by(1) }
end
