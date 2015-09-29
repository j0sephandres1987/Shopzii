class Collection < ActiveRecord::Base
  has_many :categories
  has_many :products
  #belongs_to :store

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
  validates_presence_of :name
end
