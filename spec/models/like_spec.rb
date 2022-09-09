require 'rails_helper'

RSpec.describe Like, type: :model do
  # tests go here
  before :each do
    @author = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(title: 'title', text: 'Some text', author_id: @author.id)
    @like = Like.create(author_id: @author.id, post_id: @post.id)
  end

  it 'Should be valid' do
    expect(@like).to be_valid
  end

  context 'Associations' do
    it 'Should belong to an Author' do
      assc = described_class.reflect_on_association(:author)
      expect(assc.macro).to eq :belongs_to
    end

    it 'Should belong to a post' do
      assc = described_class.reflect_on_association(:post)
      expect(assc.macro).to eq :belongs_to
    end
  end

  context 'custom methods' do
    it 'Should update the likes' do
      expect(@like.update_like_counter).to eq(@post.update(likes_count: @post.likes.count))
    end
  end
end
