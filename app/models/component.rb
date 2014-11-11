class Component < ActiveRecord::Base
  belongs_to :syllabus
  has_one :plaintext, dependent: :destroy, autosave: true
  has_one :table, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :plaintext
  accepts_nested_attributes_for :table
end
