class Store < ActiveRecord::Base
  belongs_to :user
  def mercado_pago_checkout
    #mercado-pago-api
    # Credenciales
    client_id = '6654385989025497'
    client_secret = 'smsV7QBUQupQ1FNEcr8Fb7uMl1AGVbE6'

    mp_client = Mercadopago::Sdk.new(client_id, client_secret)
    data = {
        :items => [
            {
                :title => "Title of product",
                :currency_id => "COP",
                :unit_price => 2000.50,
                :quantity => 2,
            }
        ]
    }
    preference = mp_client.create_checkout_preference(data)
    return preference
  end
end
