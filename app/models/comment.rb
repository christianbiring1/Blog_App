class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', counter_cache: true, foreign_key: 'post_id'

  def update_comments_counter
    post.update(comments_count: post.comments.count)
  end
end
