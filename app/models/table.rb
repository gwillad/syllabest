class Table < ActiveRecord::Base
  belongs_to :component
  serialize :contents
  attr_accessible :title, :contents, :rows, :columns, :border_class, :component_id
end
