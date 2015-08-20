require 'HTTParty'

class ShippingClient
  SHIPPING_URI = "http://localhost:3000/shipping"

  def self.find_shipping_rates(params, products)
    shipment = set_shipment(params, products)
    response = HTTParty.get(SHIPPING_URI, query: shipment)
    return response
  end

  def self.send_shipping_info(id, method, cost)

    shipping_data = { :shipping_data => set_shipping_data(id, method, cost),

    response = HTTParty.post('http://localhost:3000/shipping/shipping_order', { body: shipping_data, headers: {"Content-Type" => "application/json"} })
  end

  private

  def self.set_shipment(params, products)
    {
      origin: {
        country: "US",
        state: "CA",
        city: "Beverly Hills",
        zip: "90210"
      },
      destination: {
        country: params[:country],
        state: params[:state],
        city: params[:city],
        zip: params[:zip]
      },
      products: products
    }
  end

  def self.set_shipping_data(id, method, cost)
    {
      order_id: id,
      shipping_method: method,
      shipping_cost: cost
    }.to_json
  end
end
