class Syllabus < ActiveRecord::Base
  belongs_to :user
  has_many :students #, dependent: :destroy
  has_many :components, dependent: :destroy
  accepts_nested_attributes_for :components
  serialize :header_options, Array
  serialize :office_hrs, Array
  attr_accessible :title, :location, :course_num, :department, :term, :section_num, :course_type, :user_id, :header_options, :office_hrs
  validates_presence_of :title, :department, :message => "Field is required"
  validates_format_of :course_num, :section_num, :with => /\A\d+\z/, :message => "Numeric characters only", :allow_blank => true
end

