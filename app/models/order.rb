class Order < ActiveRecord::Base
  has_many :cart_items
end
