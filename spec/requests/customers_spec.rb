require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    it 'JSON Schema' do
      get '/customers/1.json'
      expect(response).to match_response_schema("customers")
    end
    it "works! 200 OK" do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it "JSON! 200 OK" do
      get '/customers.json'

      expect(response.body).to include_json([
                                              id: 1,
                                              name: (be_kind_of(String)),
                                              email: (be_kind_of(String))
                                            ])
    end

    it 'Show RSpec puro' do
      get '/customers/1.json'
      response_body = JSON.parse(response.body)
      expect(response_body.fetch("id")).to eq(1)
      expect(response_body.fetch("name")).to be_kind_of(String)
      expect(response_body.fetch("email")).to be_kind_of(String)
    end

    it 'Create JSON' do
      member = create(:member)
      login_as(member, :scope => :member)

      headers = { "ACCEPT": "application/json" }

      customer_params = attributes_for(:customer)

      post '/customers.json', params: { customer: customer_params }, headers: headers

      expect(response.body).to include_json(
                                 id: (be_kind_of(Integer)),
                                 name: customer_params.fetch(:name),
                                 email: customer_params.fetch(:email)
                               )
    end

    it 'Update - JSON' do
      member = create(:member)
      login_as(member, :scope => :member)

      headers = { "ACCEPT": "application/json" }

      customer = Customer.first
      customer.name += " - Atualizado"


      patch "/customers/#{customer.id}.json", params: { customer: customer.attributes }, headers: headers

      expect(response.body).to include_json(
                                 id: (be_kind_of(Integer)),
                                 name: customer.name,
                                 email: customer.email
                               )
    end

    it 'Destroy - JSON' do
      member = create(:member)
      login_as(member, :scope => :member)

      headers = { "ACCEPT": "application/json" }

      customer = Customer.first

      expect { delete "/customers/#{customer.id}.json", headers: headers }.to change(Customer, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
