class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates :username, presence: true, length: { minimum: 3 }, 
                                uniqueness: { case_sensitive: false },
                                format: { with: /\A[a-zA-Z0-9_]+\Z/,
                                          message: "can only include letters, 
                                          numbers, and underscores" }
  validates_presence_of :password, :on => :create
  has_secure_password
  validates :password, on: :create, length: { minimum: 8 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :time_zone, presence: true
  
  def to_param
    self.username
  end
  
  def username=(s)
    write_attribute(:username, s.to_s.downcase)
  end
  
  def email=(s)
    write_attribute(:email, s.to_s.downcase)
  end
  
  def first_name=(s)
    write_attribute(:first_name, s.to_s.capitalize)
  end
  
  def last_name=(s)
    write_attribute(:last_name, s.to_s.capitalize)
  end

end