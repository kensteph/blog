class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end
end
