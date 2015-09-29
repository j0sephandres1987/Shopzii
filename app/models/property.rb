class Property < ActiveRecord::Base
  belongs_to :product
  has_many :values

  validates_presence_of :name
end
