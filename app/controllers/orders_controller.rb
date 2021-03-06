class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(:user_id=>current_user.id).last
    @user_add = Address.where(:user_id=>current_user.id).first
    if !@orders.present?
      redirect_to root_url, notice: "No Order Found"
      return
    end

    @order_item = @orders.line_items
    # @order_item.each do |xx|
    #   puts ">>>>>>>>>>>>#{xx.product.name}"
    # end
    # puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{order_item.inspect}"
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
     if @cart.line_items.empty?
      redirect_to root_url, notice: "Your cart is empty"
      return
     end
     # @user_id = session[:user_id]
    @order = Order.new

  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user_id = session[:user_id]
    @order.add_line_items_from_cart(@cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to  @order, notice:'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # def order_success
  #     respond_to do |format|
  #       format.html { redirect_to root_url, notice:'Thank you for your order.' }
  #     end
  # end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:payment_type)
    end
end
