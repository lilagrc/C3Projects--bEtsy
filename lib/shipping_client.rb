require 'HTTParty'

class ShippingClient
  SHIPPING_URI = "http://localhost:3000/shipping/"

  def self.find_shipping_rates(params)
    set_address_variables(params)
    response = HTTParty.get(SHIPPING_URI + "destination_country=#{@country}&destination_state=#{@state}&destination_city=#{@city}&destination_zip=#{@zip}&origin_country=US&origin_state=CA&origin_city=Beverly%20Hills&origin_zip=90210&package_length=90&package_width=10&package_weight=110")
    raise
  end

  private

  def self.set_address_variables(params)
    @country = params[:country]
    @state = params[:state]
    @city = params[:city]
    @zip = params[:zip]
  end
end
