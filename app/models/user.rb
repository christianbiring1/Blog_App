class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  # Associations
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  after_initialize :init
  before_create :set_default_avatar

  # Validation

  validates :name, presence: true
  validates :posts_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def three_last_posts
    posts.order('created_at').last(3)
  end

  def init
    self.posts_count ||= 0
    true
  end

  def set_default_avatar
    self.photo = 'https://images.unsplash.com/photo-1660503427782-f9c627e7066e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80'
  end

  def admin?
    self.role = 'admin'
  end
end
