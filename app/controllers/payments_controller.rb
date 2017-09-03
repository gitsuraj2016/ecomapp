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

  def payu_return
    begin
      notification = PayuIndia::Notification.new(request.query_string, options = {:key => 'yjAxoB55', :salt => 'sJBuaXoezs', :params => params})    
      payment = Payment.find(notification.invoice)  # invoice is nothing but the payment_id
      if notification.acknowledge
        begin
          if notification.complete?
            payment.status = params[:status]
            payment.paid_at = params[:addedon]
            payment.card_num = params[:cardnum]
            payment.ip = request.remote_ip
            payment.Payer_id = params[:mihpayid]

            # order = Order.new
            # order.user_id =
            # order.order_number = 
            # order.payment_type = 
            # order.payment_id = 
            # order.payment_state = 
            # order.payment_date = 
            # order.shipment_state = 
            # order.shipment_amount =  
            # order.discount_amount = 
            # order.total_amount = 
            # oredr.save
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
