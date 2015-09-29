require 'rubygems'
require 'rack'
require 'mercadopago.rb'

class Button
  def call(env)
    mp = MercadoPago.new('6654385989025497', 'smsV7QBUQupQ1FNEcr8Fb7uMl1AGVbE6')
    preferenceData = {
        "items" => [
            [
                "title"=>"Multicolor kite",
                "quantity"=>1,
                "unit_price"=>10.0,
                "currency_id"=>"COP" # Available currencies at: https://api.mercadopago.com/currencies
            ]
        ]
    }
    preference = mp.create_preference(preferenceData)

    html =  '<a href="' + preference['response']['init_point'] + '">Pay</a>'

    return [200, {'Content-Type' => 'text/html'}, [html]]
  end
end

Rack::Handler::WEBrick.run(Button.new, :Port => 9000)