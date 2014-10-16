class Idea < ActiveRecord::Base
  
  attr_accessible :title, :body, :user_id, :category, :archived_at, :attachments_attributes, :priority

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :title, presence: true
  validates :user_id, presence: true

  scope :by_latest, -> { order("updated_at desc") }
  scope :active, -> { where("archived_at IS NULL") }
  scope :archived, -> { where("archived_at IS NOT NULL") }
  scope :sort_by_count_votes_desc, -> do 
    select("ideas.*, COUNT(votes.id) as count_votes")
      .joins("LEFT OUTER JOIN votes ON ideas.id = votes.idea_id")
      .group("ideas.id").order("count_votes desc")
  end
  scope :sort_by_count_votes_asc, -> do
    select("ideas.*, COUNT(votes.id) as count_votes")
      .joins("LEFT OUTER JOIN votes ON ideas.id = votes.idea_id")
      .group("ideas.id").order("count_votes asc")
  end

  def archived?
    self.archived_at
  end

  def self.import(file, user)
    contents = []
    contents = CSV.read(file.path)
    contents.shift
    contents.each do |row|
      Idea.create(priority: row[0].to_i, title: row[1], body: row[2], user_id: user)
    end
  end

end
