class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates :username, presence: true, length: { minimum: 3 }, 
                                        uniqueness: { case_sensitive: false }
  validates_presence_of :password, :on => :create
  has_secure_password
  validates :password, on: :create, length: { minimum: 8 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  
  def first_name=(s)
    write_attribute(:first_name, s.to_s.capitalize)
  end
  
  def last_name=(s)
    write_attribute(:last_name, s.to_s.capitalize)
  end
end