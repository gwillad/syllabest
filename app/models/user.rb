class User < ActiveRecord::Base
  has_many :syllabuses, dependent: :destroy
  validates_presence_of :first_name
end
