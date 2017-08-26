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
end
