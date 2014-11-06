class Component < ActiveRecord::Base
	belongs_to :syllabus
	has_one :plaintext, dependent: :destroy, autosave: true
	accepts_nested_attributes_for :plaintext
end
