require 'rails_helper'

RSpec.describe User, type: :system do
  before :each do
    @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @user2 = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVv1', bio: 'Teacher from Poland.')
    @user1.posts.create(title: 'This is my first post', text: 'This is the content of my first post')
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

  describe 'user show page' do
    it 'The profil picture should be visible' do
      visit user_path(@user1.id)
      expect(page).to have_css("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
    end

    it 'Should show the user\'s name' do
      visit user_path(@user1.id)
      expect(page).to have_content('Tom')
    end

    it 'Should show the number of post the user have' do
      visit user_path(@user1.id)
      expect(page).to have_content('Number of posts: 1')
    end

    it 'Should show the user\'s bio' do
      visit user_path(@user1.id)
      expect(page).to have_content('Teacher from Mexico.')
    end

    it 'Should show the user\'s first three posts' do
      i = 1
      3.times do
        @user1.posts.create(title: "Post#{i}", text: 'Post content')
        i += 1
      end
      visit user_path(@user1.id)
      expect(page).to have_content('Post1')
      expect(page).to have_content('Post2')
      expect(page).to have_content('Post3')
    end

    it 'Should display see all posts button' do
      visit user_path(@user1.id)
      expect(page).to have_content('See all posts')
    end

    it 'Should display all user post' do
      visit user_path(@user1.id)
      click_link 'See all posts'
      expect(current_path).to eq(user_posts_path(@user1.id))
    end
  end

  describe 'User posts index page' do
    it 'Should display user photo' do
      visit user_posts_path(@user1.id)
      expect(page).to have_css("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
    end

    it 'Should display user name' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('Tom')
    end

    it 'Should display user s posts count ' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('Number of posts: 1')
    end

    it 'Should display post title' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('This is my first post')
    end
  end

  describe 'User posts show page' do
    it 'Should display the post text' do
      visit user_posts_path(@user1.id)
      expect(page).to have_content('This is the content of my first post')
    end

    it 'Should display the number of comments' do
      visit user_post_path(@user1.id, @user1.posts.first.id)
      expect(page).to have_content('Comments: 0')
    end

    it 'Should display first comment' do
      @user1.comments.create(post_id: @user1.posts.first.id, text: 'First Comment')
      visit user_posts_path(@user1.id)
      expect(page).to have_content('First Comment')
    end

    it 'Should redirect to post s page' do
      visit user_posts_path(@user1.id)
      click_link 'This is my first post'
      expect(current_path).to eq(user_post_path(@user1.id, @user1.posts.first.id))
    end
  end
end
