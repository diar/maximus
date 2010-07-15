class Admin::UsersController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_authorize
  layout 'admin'
  
  def index
    @users = User.all
		@title = 'Список пользователей'
	end

  def new
    @title = 'Добавление пользователя'
    @user = User.new
  end
 
  def create
		@user = User.new(params[:user])
		@title = 'Добавление пользователя'
		respond_to do |format|
  		if @user.save
    		flash[:notice] = "Пользователь добавлен"
    		format.html { redirect_to(:controller=>'users') }
 			else
    		format.html { render :action => "new" }
  		end
		end
  end
end
