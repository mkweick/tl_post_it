class Post < ActiveRecord::Base
  include Voteable
  include Sluggable
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  
  validates :title, presence: true, length: { minimum: 6, maximum: 30 }
  validates :url, presence: true
  validates :description, presence: true
  
  def to_param
    self.slug
  end
  
  def self.recent
    order(created_at: :desc)
  end
  
  # override the default values returned from JSON API call
  def as_json(options={})
    options ||= { only: [:title, :url, :description, :votes_count] }
    super(options)
  end
end