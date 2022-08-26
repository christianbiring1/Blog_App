require 'rails_helper'

RSpec.describe User, type: :model do
  #tests go here
  before :each do
    @user = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  end

  it 'is valid with valid attributes' do
    @user.save
    expect(@user).to be_valid
  end

  it 'name should be present' do
    @user.name = nil
    @user.save
    expect(@user).to_not be_valid
  end

  it 'post counter should be  integer' do
    @user.posts_counter = 'first'
    @user.save
    expect(@user).to_not be_valid
  end

  it 'post counter should be greater or equal to zero' do
    @user.posts_counter = -1
    @user.save
    expect(@user).to_not be_valid
  end

  it 'Is valid without a photo or bio' do
    @user.photo = nil
    @user.bio = nil
    @user.save
    expect(@user).to be_valid
  end

  context 'associations' do
    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'has many likes' do
      assc = described_class.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end

    it 'has many posts' do
      assc = described_class.reflect_on_association(:posts)
      expect(assc.macro).to eq :has_many
    end
  end

  context 'Costum methods' do
    it 'is showing the last three posts' do
      @user.save
      expect(@user.three_last_posts.count).to eq(@user.posts.order('created_at').last(3).count)
    end
  end
end