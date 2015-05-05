class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email, :username, :password, :password_confirmation
  validates_uniqueness_of :email
  validates :username, length: {minimum: 7}
  has_secure_password  
  validates :password, length: {minimum: 7}
  before_save :capitalize_name

  def capitalize_name
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
  end
end
