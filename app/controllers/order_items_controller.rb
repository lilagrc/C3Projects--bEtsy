class OrderItemsController < ApplicationController

  def create
    @order = current_order

    calc_revenue

    @order_item = @order.order_items.create(order_item_params)
    session[:order_id] = @order.id

    redirect_to '/cart'
  end

  def update
    @order_item = OrderItem.find(params[:id])

    calc_revenue

    @order_item.update_attributes(order_item_params)
    
    redirect_to(:back)
  end

  def calc_revenue
    product = Product.find(params[:order_item][:product_id])
    params[:order_item][:revenue] = params[:order_item][:quantity].to_i * product.price
  end

  def destroy
    # if a customer decreases the qty number for a product in the cart view (i.e. 3 > 1 sweater)
    # if a customer clicks an 'x' in the cart view to remove all units of that product??
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

    redirect_to(:back)
  end

  def check_stock
    # when you create a new order_item, it needs to check that the stock for
    # that product is >= the total number of order_items that you want
  end

  def mark_shipped
    order_item = OrderItem.find(params[:id])
    order_item.update(shipped: true)

    redirect_to(:back)
  end

###############################################
  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :order_id, :revenue, :quantity, :shipped, :merchant_id)
  end

end
