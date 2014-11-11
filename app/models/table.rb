class Table < ActiveRecord::Base
  belongs_to :component
  serialize :contents
end
