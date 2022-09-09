require 'rails_helper'

RSpec.describe User, type: :system do
  before :each do
    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @user2 = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVv1', bio: 'Teacher from Poland.')
    @user1.posts.create(title: 'This first post', text: 'This is the content of my first post')
    @user2.posts.create(title: 'This is my first post', text: 'This is the content of my second post')
  end
  describe 'index page' do
    it 'Should show the user\'s name' do
      visit '/'
      expect(page).to have_content('Tom')
      expect(page).to have_content('Lilly')
    end

    it 'Should show the user\'s posts number' do
      visit root_path
      expect(page).to have_content('Number of posts: 1')
    end

    it 'should display user photo' do
      visit root_path
      expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
      expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVv1']")
    end

    it 'When clicked, the user should be redirect to the show page' do
      visit root_path
      click_link 'Tom'
      expect(current_path).to eq(user_path(@user1.id))
    end
  end
end