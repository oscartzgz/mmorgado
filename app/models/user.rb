class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, # :registerable, :recoverable,
         :rememberable, :validatable

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username

  before_validation :validate_email_presence
  
  attr_writer :login
  
  def login
    @login || self.username || self.email
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  protected

  def validate_email_presence
    self.email = "#{Time.now.to_i}@example.com" if self.email.blank?
    
    if self.password.blank? and self.encrypted_password.blank?
      self.password = SecureRandom.hex(30)
      self.password_confirmation = self.password
    end
  end
end
