class Plaintext < ActiveRecord::Base
  belongs_to :component
  attr_accessible :title, :contents, :component_id
end
