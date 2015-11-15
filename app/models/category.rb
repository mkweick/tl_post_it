class Category < ActiveRecord::Base
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories
  
  def to_param
    self.name.downcase
  end
  
  def self.alphabetize
    order(name: :asc)
  end
end