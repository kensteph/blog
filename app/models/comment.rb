class Comment < ApplicationRecord
  belongs_to :post

  belongs_to :post
  belongs_to :author, class_name: 'User'
  after_save :update_post_comments_counter

  
end
