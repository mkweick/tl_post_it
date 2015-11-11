class Comment < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :post
  has_many :votes, as: :voteable, dependent: :destroy
  
  validates :body, presence: true
  
  def self.recent
    order(created_at: :desc)
  end
  
  def total_votes
    self.votes.where(vote: true).size
  end
  
  def user_voted?(current_user)
    self.votes.where(user_id: current_user).any?
  end
end