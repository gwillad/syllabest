class Syllabus < ActiveRecord::Base
  belongs_to :user
  has_many :students #, dependent: :destroy
  has_many :components, dependent: :destroy
  accepts_nested_attributes_for :components
  attr_accessible :title, :location, :course_num, :department, :term, :section_num, :course_type, :user_id
end
