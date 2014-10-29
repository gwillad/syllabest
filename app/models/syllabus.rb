class Syllabus < ActiveRecord::Base
  belongs_to :user
  has_many :students #, dependent: :destroy
  has_many :components, dependent: :destroy
  accepts_nested_attributes_for :components
end
