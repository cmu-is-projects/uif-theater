class ItemColor < ActiveRecord::Base
  belongs_to :color
  belongs_to :item
end
