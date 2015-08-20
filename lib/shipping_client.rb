require 'HTTParty'

class ShippingClient
  SHIPPING_URI = "http://localhost:3000/shipping"

  def self.find_shipping_rates(params, products)
    shipment = set_shipment(params, products)
    response = HTTParty.get(SHIPPING_URI, query: shipment)
    return response
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
end
