class Syllabus < ActiveRecord::Base
	belongs_to :user
	has_many :components
end
