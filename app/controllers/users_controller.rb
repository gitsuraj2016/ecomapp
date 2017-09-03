class UsersController < ApplicationController
  def new
  end

  def register

    user_name = params[:name]
    user_email = params[:email]
    user_pass = params[:password]
    # user_cpass = params[:password_confirmation]

    user = User.new
    user.name = user_name
    user.email = user_email
    user.password = user_pass
    user.password_confirmation = user_pass
    user.save


   # respond_to do |format|
   #    if user.save
   #       session[:user_id] = user.id
   #      format.html { redirect_to root_url, notice: 'Login Successfully.' }
   #      format.js
   #      # format.json { render :show, status: :created, location: @product }
   #    else
   #      format.html { redirect_to root_url, notice: 'Login Erro' }
   #      # format.js
   #      # format.json { render json: @product.errors, status: :unprocessable_entity }
   #    end
   #  end

    if user.present?
     session[:user_id] = user.id
     render :json => {:success => 'success', :user_id => user.id}.to_json
     # redirect_to root_url, notice: 'Login Successfully'
    else
  	 render :json => {:success => 'Error'}.to_json
    end
  end

  def login

    # user_name = params[:name]
    user_email = params[:email]
    user_pass = params[:password]
    user = User.find_by(email: user_email)
    if user && user.authenticate(user_pass)
    	session[:user_id] = user.id
      flash[:notice] = 'login successfully.'
    	render :json => {:success => 'success', :user_id => user.email}.to_json
    else
      render :json => {:success => 'Invalid User'}.to_json
    end
   
  end

  def my_profile
       @user_det =  User.where(:id => current_user.id).first


    #  respond_to do |format|
    #   if @product.save
    #     format.html { redirect_to @product, notice: 'Product was successfully created.' }
    #     format.json { render :show, status: :created, location: @product }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end
  
  def sign_out

    session[:user_id] = nil
    redirect_to root_url, notice: 'Log out Successfully'
   
  end

  def save_address

        sfname = params[:sfname]
        slname = params[:slname]
        semail = params[:semail]
        sphone = params[:sphone]
        saddress = params[:saddess]
        spincode = params[:spincode]
        add_same =  params[:add_same]
        bfname = params[:bfname]
        blname = params[:blname]
        bemail = params[:bemail]
        baddress = params[:baddress]
        bcity = params[:bcity]
        bstate = params[:bstate]
        bpincode = params[:bpincode]
        bcountry = params[:bcountry]
        bphone = params[:bphone]

        myadd = Address.where(:user_id=>current_user.id).first
       if myadd.present?
        myadd = myadd
       else
        myadd = Address.new
       end
        myadd.user_id = current_user.id
        myadd.sfirst_name = sfname
        myadd.slast_name = slname
        myadd.saddress = saddress
        # myadd.scity 
        # myadd.sstate
        myadd.spincode = spincode
        myadd.sphone = sphone
        myadd.semail = semail
        # myadd.scountry
        if add_same.to_i == 1
          myadd.bfirst_name = sfname
          myadd.blast_name = slname
          myadd.baddress = saddress
          # myadd.bcity
          # myadd.bstate
          myadd.bpincode = spincode
          myadd.bphone = sphone
          myadd.bemail = semail
          # myadd.bcountry
          myadd.add_same = 1
        else
          myadd.bfirst_name = bfname
          myadd.blast_name = blname
          myadd.baddress = baddress
          myadd.bcity = bcity
          myadd.bstate = bstate
          myadd.bpincode = bpincode
          myadd.bphone = bphone
          myadd.bemail = bemail
          myadd.bcountry = bcountry
          myadd.add_same = 0
        end
        # myadd.add_same
        myadd.save
      
        redirect_to :back, notice: 'Address Save Successfully'
   
  end
end
