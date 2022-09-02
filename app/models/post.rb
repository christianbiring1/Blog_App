class Post < ApplicationRecord
  # Associations
  belongs_to :author, class_name: 'User', counter_cache: true, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  after_initialize :init

  # Validations

  validates_presence_of :title, :text
  validates :title, length: { maximum: 250 }
  validates :comments_count, :likes_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_posts_counter
    author.update(posts_count: author.posts.count)
  end

  def five_last_comments
    comments.order('created_at').last(5)
  end

  def init
    self.comments_count ||= 0
    self.likes_count ||= 0
    true
  end
end
