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
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :time_zone, presence: true
  validates :phone, allow_nil: true, uniqueness: { allow_blank: true },
                    length: { is: 10, message: "must be 10 digits only" }
  
  def to_param
    self.username
  end
  
  def username=(s)
    write_attribute(:username, s.to_s.downcase)
  end
  
  def email=(s)
    write_attribute(:email, s.to_s.downcase)
  end
  
  def phone=(s)
    write_attribute(:phone, s.gsub(/[\D]/, '').to_s)
  end
  
  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end
  
  def send_pin_to_twilio
    account_sid = 'AC2a7dd8e136d95d430f92e4dbcc896cd5' 
    auth_token = '784a94e4b0ceb7214d0e7ee680c504d6' 
    
    client = Twilio::REST::Client.new(account_sid, auth_token)
    
    msg = "Your Postit! login pin is: #{self.pin}"
    client.account.messages.create({ :from => '+17163010509', :to => self.phone,
                                     :body => msg })
  end
  
  def clear_user_pin!
    self.update_column(:pin, nil)
  end
end