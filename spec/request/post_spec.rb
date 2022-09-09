require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  before(:each) do
    @user = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
    @post = Post.create(title: 'This is my first post', text: 'Some content', author_id: @user.id)
  end
  describe 'GET #index' do
    before(:example) do
      get "/users/#{@user.id}/posts"
    end

    it 'Is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    before(:example) do
      get "/users/#{@user.id}/posts/#{@post.id}"
    end

    it 'Should be successful' do
      expect(response).to have_http_status(:ok)
    end

    it 'Should render the correct template' do
      expect(response).to render_template(:show)
    end
  end
end
