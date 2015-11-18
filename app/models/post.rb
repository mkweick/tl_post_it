class Post < ActiveRecord::Base
  include Voteable
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  
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
  
  # override the default values returned from JSON API call
  def as_json(options={})
    options ||= { only: [:title, :url, :description, :votes_count] }
    super(options)
  end
end