class User < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :email, presence: true
  validates :password, :presence =>true,
                    :length => { :minimum => 5},
                    :confirmation =>true
  validates_confirmation_of :password
  

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    if user && user.authenticate(password)
      return user
    end
    return false
  end

end