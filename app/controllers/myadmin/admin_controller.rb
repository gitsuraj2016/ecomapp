class Myadmin::AdminController < ApplicationController
	before_action :authenticate_admin!
	layout "myadminlayout"
  def index
  	
  end
end
