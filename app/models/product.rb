class Product < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :category
  belongs_to :collection
  has_many :photos
  has_many :cart_items
  has_many :properties
  has_and_belongs_to_many :shipment_methods
  #belongs_to :store

  accepts_nested_attributes_for :photos
  validates_presence_of :name
  validates_presence_of :stock
  validates_numericality_of :price
  validates_numericality_of :stock

  scope :sorted_by_date_desc, lambda { order("created_at DESC") }
  scope :select_data, lambda { |search, sort_by_option, order|
                      unless search.nil?
                        where('name LIKE ?', "%#{search}%").order("#{sort_by_option} #{order}")
                      else
                        unless sort_by_option.nil? && order.nil?
                          order("#{sort_by_option} #{order}")
                        else
                          order("created_at ASC")
                        end
                      end
                    }

  scope :filter, lambda { |field, value|
                        where(field => value)
                    }

end
