class Student < ActiveRecord::Base
  belongs_to :syllabus
  attr_accessible :first_name, :id, :created_at, :updated_at, :last_name, :email, :class_year
  validates_presence_of :email, :message => "Email is required"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid email address"
  validates_format_of :class_year, :with => /\A\d{4}\z/, :message => "Class year must be entered as 4 numberic digits (ex: 1812)", :allow_blank => true
end
