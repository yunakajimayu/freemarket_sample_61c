require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #done' do
    it 'returns http success' do
      get :done
      expect(response).to have_http_status(:success)
    end
  end

describe ItemsController do
  describe 'GET #index' do
    it "populates an array of chanels ordered by created_at DESC" do
      chanels = create_list(:item, 3) 
      get :index
      expect(assigns(:chanels)).to match(chanels.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "renders the :index template" do
    end
  end

end