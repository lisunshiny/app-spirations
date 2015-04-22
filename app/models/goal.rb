class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates :private, :complete, inclusion: {in: [true, false]}

  belongs_to :user
  has_many :comments, as: :commentable

  def render_status
    self.complete ? "Completed" : "In progress"
  end

end
