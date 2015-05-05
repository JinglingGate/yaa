class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :email
  validates :username, length: {minimum: 7}
  has_secure_password  
  validates :password, length: {minimum: 7}
  validates_presence_of :password_confirmation
  before_save :capitalize_name

  def capitalize_name
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end
 end
