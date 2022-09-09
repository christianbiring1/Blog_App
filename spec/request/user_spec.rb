require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before(:each) do
    @user = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
  end
  describe 'GET /index' do
    before(:example) { get users_path }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end

    it 'Should includes the template' do
      expect(response.body).to include('Tom')
    end
  end

  describe 'GET /show' do
    before(:example) do
      get "/users/#{@user.id}"
    end

    it 'Should be successful' do
      expect(response).to have_http_status(:ok)
    end

    it 'Should render the correct template' do
      expect(response).to render_template(:show)
    end

    # it 'Should contain the correct test' do
    #   expect(response.body).to include('Bio: Teacher from Mexico')
    # end
  end
end
