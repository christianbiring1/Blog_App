class Comment < ApplicationRecord
  belongs_to :users, posts
end
