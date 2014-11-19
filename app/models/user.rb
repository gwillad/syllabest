class User < ActiveRecord::Base
  has_many :syllabuses, dependent: :destroy
  validates_presence_of :email, :password, :last_name, :first_name, :office, :school, :message => "Field is required"
  validates_uniqueness_of :email, :message => "A user with this e-mail already exists"
  validates_length_of :password, minimum: 6, maximum: 30, :message => "Password must be between 6 and 30 characters."
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid e-mail address"
  before_save {|user| user.email = email.downcase }
end
