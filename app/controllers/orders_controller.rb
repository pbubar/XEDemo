class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end
  
  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    respond_with(@order)
  end

  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
    respond_with(@order)
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.buyer_id = current_user.id
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user

    @order.listing_id = @listing_id
    @order.seller_id = @seller.id
    @order.save
    flash[:notice] = 'Order was successfully created.' if @order.save
    respond_with(@order, :location => root_url, notice: "Order created")
  end

  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end
