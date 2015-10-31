class Category < ActiveRecord::Base
  before_save :capitalize_name
  
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  private
  
  def capitalize_name
    self.name = self.name.split(' ').map{ |word| word.capitalize }.join(' ')
  end
end