class User < ApplicationRecord
  # Associations
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  # Validation

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def three_last_posts
    posts.order('created_at').last(3)
  end
end
