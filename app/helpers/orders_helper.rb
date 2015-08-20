module OrdersHelper
  def shipping_cost(cost)
    return "$#{cost/100.00}"
  end
end
