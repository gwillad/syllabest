class Component < ActiveRecord::Base
	belongs_to :syllabus
	has_one :plaintext
	accepts_nested_attributes_for :plaintext
end
