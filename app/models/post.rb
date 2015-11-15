class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 6, maximum: 30 }
  validates :url, presence: true
  validates :description, presence: true
  
  def self.recent
    order(created_at: :desc)
  end
  
  def self.votes_then_recent
    order(votes_count: :desc, created_at: :desc)
  end
  
  def user_voted?(current_user)
    self.votes.where(creator: current_user).any?
  end
end