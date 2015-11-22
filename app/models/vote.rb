class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true, counter_cache: true  #:votes_count
  
  validates_uniqueness_of :creator, scope: [:voteable_type, :voteable_id]
end