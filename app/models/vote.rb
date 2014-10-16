class Vote < ActiveRecord::Base
  attr_accessible :value, :user_id, :idea_id

  belongs_to :user
  belongs_to :idea

  # validates :idea_id, uniqueness: { scope: :user_id } # commented out for debugging
  validates :user_id, presence: true
  validates :value, presence: true

  scope :up_vote,   ->{ where("value > 0") }
  scope :down_vote, ->{ where("value < 0") }
end
