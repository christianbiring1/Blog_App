require 'rails_helper'

RSpec.describe Post, type: :model do
  # tests go here
  before :each do
    @author = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  end

  # rubocop:disable Metrics/BlockLength
  context 'validation' do
    it 'is valid with attributes' do
      post = Post.create(title: 'Title', text: 'text', author_id: @author.id)
      expect(post).to be_valid
    end

    it 'title most be present' do
      post = Post.create(title: nil, text: 'text', author_id: @author.id)
      expect(post).to_not be_valid
    end

    it 'Not valid with a title exceeding 250 characters' do
      header = 'a' * 251
      post = Post.create(title: header, text: 'some text', author_id: @author.id)
      expect(post).to_not be_valid
    end

    it 'Should not be valid without a text' do
      post = Post.create(title: 'title', text: nil, author_id: @author.id)
      expect(post).to_not be_valid
    end

    it 'Should not be valid without the auhtor id' do
      post = Post.create(title: 'title', text: 'Some text')
      expect(post).to_not be_valid
    end

    it 'Sould not be valid with comments counter in string' do
      post = Post.create(title: 'title', text: 'Some text', author_id: @author.id)
      post.comments_counter = 'first'
      expect(post).to_not be_valid
    end

    it 'Sould not be valid with likess counter in string' do
      post = Post.create(title: 'title', text: 'Some text', author_id: @author.id)
      post.likes_counter = 'first like'
      expect(post).to_not be_valid
    end
  end
  # rubocop:enable Metrics/BlockLength

  context 'Associations' do
    it 'Should have many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'Should have many likes' do
      assc = described_class.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end
  end

  context 'Costum methods' do
    it 'Should show the three last posts' do
      post = Post.new(title: 'title', text: 'Body', author_id: @author.id)
      expect(post.five_last_comments.count).to eq(post.comments.order('created_at').last(5).count)
    end
  end
end
