class ShipmentMethod < ActiveRecord::Base
  has_and_belongs_to_many :products

  validates_presence_of :name
  validates_presence_of :price
  validates_numericality_of :price

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
end
