class Store < ActiveRecord::Base
  belongs_to :user
  def mercado_pago_checkout(data)
    client_id = '8627032368043742'
    client_secret = 'OwtK5d95rxQhVvyQDJd9mD9Xxu3TzN3v'

    mp_client = Mercadopago::Sdk.new(client_id, client_secret, true)
    preference = mp_client.create_checkout_preference(data)
    return preference
  end
end
