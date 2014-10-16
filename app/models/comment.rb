class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :idea_id

  belongs_to :idea
  belongs_to :user

  validates :body, presence: true
  validates :user_id, presence: true
  validates :idea_id, presence: true
end
