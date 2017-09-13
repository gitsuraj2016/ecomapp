class PaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => [:payu_return]
  def mypayment

     if !current_user.present?
         redirect_to root_url, notice: "Please Login"
         return
     end

      if session[:cart_id].present?
        @cart = Cart.find(session[:cart_id])
        if @cart.line_items.empty?
          redirect_to root_url, notice: "Your cart is empty"
          return
        end
      else
          redirect_to root_url, notice: "Your cart is empty"
          return
      end

      myadd = Address.where(:user_id=>current_user.id).first
      if !myadd.present?
          redirect_to root_url, notice: "Add your billing and shipping address"
          return
      end

      pp = Payment.new
      pp.save

      @payment_paid_amount = @cart.total_price
      @payment_id = pp.id
      @payment_first_name = myadd.sfirst_name
      @payment_email = myadd.semail
      @payment_phone = myadd.sphone
  end

  def cod_confirmation

     if !current_user.present?
         redirect_to root_url, notice: "Please Login"
         return
     end

      if session[:cart_id].present?
        @cart = Cart.find(session[:cart_id])
        if @cart.line_items.empty?
          redirect_to root_url, notice: "Your cart is empty"
          return
        end
      else
          redirect_to root_url, notice: "Your cart is empty"
          return
      end

      myadd = Address.where(:user_id=>current_user.id).first
      if !myadd.present?
          redirect_to root_url, notice: "Add your billing and shipping address"
          return
      end

      # pp = Payment.new
      # pp.save

      @payment_paid_amount = @cart.total_price
      # @payment_id = pp.id
      @payment_first_name = myadd.sfirst_name
      @payment_email = myadd.semail
      @payment_phone = myadd.sphone

  end

  def place_oreder

    
      order_last = Order.last
      @cart = Cart.find(session[:cart_id])
      order = Order.new
      order.add_line_items_from_cart(@cart)
      order.user_id = session[:user_id]
      order.order_number = order_last.id.to_i + 1
      order.payment_type = "COD"
      # order.payment_id = 
      # order.payment_state = 
      order.payment_date = Time.now
      order.shipment_state = "Ready"
      order.shipment_amount = 0 
      order.discount_amount = 0
      order.total_amount = @cart.total_price
      # order.save
      if order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        flash[:notice] = "Thank you for your order"
        redirect_to :controller => 'orders', :action => 'show', :id => order.id 
        # redirect_to  @order, notice:'Thank you for your order.'
      else
         flash[:notice] = "Payment fail!. Please try again"
         redirect_to root_url
      end

  end

  def order_success
  end

  def order_fail
  end


  def payu_return
    
    begin
      notification = PayuIndia::Notification.new(request.query_string, options = {:key => 'nD88BBBq', :salt => 'sgqO8H1mSg', :params => params})    
      payment = Payment.find(notification.invoice)  # invoice is nothing but the payment_id
      if notification.acknowledge
        begin
          if notification.complete?
            payment.status = params[:status]
            payment.paid_at = params[:addedon]
            payment.card_num = params[:cardnum]
            payment.ip = request.remote_ip
            payment.Payer_id = params[:mihpayid]

            order_last = Order.last
            @cart = Cart.find(session[:cart_id])
            order = Order.new
            order.add_line_items_from_cart(@cart)
            order.user_id = session[:user_id]
            order.order_number = order_last.id.to_i + 1
            order.payment_type = 'card'
            order.payment_id = params[:mihpayid]
            order.payment_state = params[:status]
            order.payment_date = Time.now
            order.shipment_state = "Ready"
            order.shipment_amount = 0 
            order.discount_amount = 0
            order.total_amount = @cart.total_price
            order.save

            if order.present?
              Cart.destroy(session[:cart_id])
              session[:cart_id] = nil
            end

            flash[:notice] = "Payment Done successfully!!!"
            redirect_to root_url
          else
            payment.status = "failed"
            flash[:notice] = "Payment fail!. Please try again"
            redirect_to root_url    #show.html.erb
         end
        ensure
          payment.save
        end
      end
    rescue
      flash[:notice] = "something goes wrong ! please try again after some times!!!"
      redirect_to root_url
    end
  end
end
