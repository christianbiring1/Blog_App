require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:example) do
      get '/users/1/posts'
    end

    it 'Is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end

    it 'Should contain the correct placeholders' do
      expect(response.body).to include('List of all Posts for a specific Users')
    end
  end

  describe 'GET /show' do
    before(:example) do
      get '/users/1/posts/1'
    end

    it 'Should be successful' do
      expect(response).to have_http_status(:ok)
    end

    it 'Should render the correct template' do
      expect(response).to render_template(:show)
    end

    it 'Should contain the correct palce holder' do
      expect(response.body).to include("This is a user's post among the list")
    end
  end
end
