class Syllabus < ActiveRecord::Base
  belongs_to :user
  has_many :components
  accepts_nested_attributes_for :components
end
