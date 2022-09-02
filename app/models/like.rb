class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', counter_cache: true, foreign_key: 'post_id'

  def update_like_counter
    post.update(likes_count: post.likes.count)
  end
end
