class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  def self.three_last_posts
    posts.order('created_at').last(3)
  end
end
