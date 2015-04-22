class Comment < ActiveRecord::Base
  validates :body, :commentable, presence: true
  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id

  belongs_to :commentable, polymorphic: true
end
