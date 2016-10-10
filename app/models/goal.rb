class Goal < ActiveRecord::Base

  validates :body, presence: true

  belongs_to :user
  has_many :comments, as: :commentable

end
