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
    	render :json => {:success => 'success', :user_id => user.email}.to_json
    else
      render :json => {:success => 'Invalid User'}.to_json
    end
   
  end

  def sign_out

    session[:user_id] = nil
    redirect_to root_url, notice: 'Log out Successfully'
   
  end
end
