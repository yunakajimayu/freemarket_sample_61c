require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #done' do
    it 'returns http success' do
      get :done
      expect(response).to have_http_status(:success)
    end
  end

end