class Component < ActiveRecord::Base
  belongs_to :syllabus
  has_one :plaintext, dependent: :destroy, autosave: true
  has_one :table, dependent: :destroy, autosave: true
  attr_accessible :component_type, :id, :created_at, :updated_at, :syllabus_id, :order, :plaintext_attributes, :table_attributes
  accepts_nested_attributes_for :plaintext
  accepts_nested_attributes_for :table
end
