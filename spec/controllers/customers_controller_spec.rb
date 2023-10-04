require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'As a gest' do
    context '#index' do
      it 'responds successfully' do
        get :index
        expect(response).to be_success
      end

      it 'returns a 200 response' do
        :index
        expect(response).to have_http_status(200)
      end
    end

    context '#show' do
      it 'returns a 302 response (Not Authorized)' do
        customer = create(:customer)
        get :show, params: { id: customer.id }
        expect(response).to have_http_status(302)
      end


    end
  end

  describe 'As a Logged Member' do
    it '#show' do
      member = create(:member)
      customer = create(:customer)

      sign_in member

      get :show, params: { id: customer.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      member = create(:member)
      customer = create(:customer)

      sign_in member

      get :show, params: { id: customer.id }
      expect(response).to render_template(:show)
    end
  end


end
