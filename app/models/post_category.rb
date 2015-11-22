class PostCategory < ActiveRecord::Base
  belongs_to :post
  belongs_to :category
  
  validates_uniqueness_of :post_id, scope: :category_id
end