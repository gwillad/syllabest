class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessor :password_confirmation
  attr_protected :password_digest
  #has_secure_password

  #validates :password, :confirmation => true
  validates_confirmation_of :password, :message => "Confirm password does not match password"
  has_many :syllabuses, dependent: :destroy
  validates_presence_of :email, :last_name, :first_name, :password, :password_confirmation, :message => "Field is required"
  validates_uniqueness_of :email, :message => "A user with this e-mail already exists"
  validates_length_of :password, minimum: 5, maximum: 30, :message => "Password must be between 5 and 30 characters."
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid e-mail address"
  validates_format_of :phone, :with => /\A\(?\d{3}\)?-?[0-9]{3}-?[0-9]{4}x?[0-9]*\z/, :message => "Phone number must be in 111-111-1111xEXT format", :allow_blank => true
  #validates :phone, :allow_nil => true
  #validates :phone, :length => {:minimum => 10}, :allow_blank => true
  before_save {|user| user.email = email.downcase }

  def password=(pass)
    return if pass.blank?
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end

  def authenticate(email, pass)
    user = User.find_by(email: email.downcase)
    user && BCrypt::Password.new(user.password_digest) == pass ? true : nil
  end
    

end
