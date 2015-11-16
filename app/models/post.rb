class Post < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 6, maximum: 30 }
  validates :url, presence: true
  validates :description, presence: true
  
  before_save :generate_slug
  
  def to_param
    self.slug
  end
  
  def generate_slug
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug
    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = Post.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug
  end
  
  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, '-'
    str.downcase
  end
  
  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      str + '-' + count.to_s
    end
  end
  
  def to_unique_slug(title)
    title.gsub("/\A[\W]+\z/", "-")
  end
  
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