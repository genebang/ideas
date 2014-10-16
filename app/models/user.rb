class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, 
         :validatable, :registerable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :ideas
  has_many :votes

  def self.from_omniauth(auth)
    if valid_user?(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
      end
    end
  end

  def self.valid_user?(auth)
    EMAIL_REGEX =~ auth.info.email  || auth.info.email == "genebang@gmail.com" ### adf for debugging
    # EMAIL_REGEX =~ auth.info.email
    # VALID_USERS.include?(auth.info.email)
  end

  def password_required?
    super && provider.blank?
  end

end
