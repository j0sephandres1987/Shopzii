class Value < ActiveRecord::Base
  belongs_to :property
  has_and_belongs_to_many :cart_items
  validates_presence_of :name
end
