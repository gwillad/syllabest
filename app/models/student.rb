class Student < ActiveRecord::Base
  belongs_to :syllabus
  attr_accessible :first_name, :id, :created_at, :updated_at, :last_name, :email, :class_year
end
