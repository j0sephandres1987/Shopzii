class Order < ActiveRecord::Base
  has_many :cart_items
  
  scope :sorted_by_date_desc, lambda { where(:status => true).order("created_at DESC") }
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
                    
  def mercado_pago_payment_notification(id)
    client_id = '8627032368043742'
    client_secret = 'OwtK5d95rxQhVvyQDJd9mD9Xxu3TzN3v'
    paid_orders = Array.new

    mp_client = Mercadopago::Sdk.new(client_id, client_secret, true)
    Order.all.each do |o|
      paid_orders << mp_client.get_payment_info(id)
      #o.client_email = paid_orders.first
      o.client_name = paid_orders.first.first.first
      #o.client_email = paid_orders['payer'].to_a[3][1]
      #o.client_name = paid_orders['payer'].to_a[1][1] + " " + paid_orders['payer'].to_a[2][1]
      o.save
    end
  
    return paid_orders
  end
end
