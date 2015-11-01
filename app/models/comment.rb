class Comment < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :post
  validates :body, presence: true
  
  def self.recent
    order('created_at DESC')
  end
end