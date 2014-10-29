class User < ActiveRecord::Base
  has_many :syllabuses, dependent: :destroy
  validates_presence_of :email, :password, :last_name, :first_name, :office, :school
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 6, maximum: 30
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
