class User < ActiveRecord::Base
  has_many :syllabuses, dependent: :destroy
end
