require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '#full_name' do
    customer = create(:user, name: 'Moshé')
    customer = build(:user, name: 'Moshé')
    expect(customer.full_name).to eq('Sr. Moshé')
  end

  it 'Usando o attributes_for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.full_name).to start_with('Sr')
  end

  it { expect{create(:customer)}.to change{Customer.all.size}.by(1) }
end
