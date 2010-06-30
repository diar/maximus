class Admin::UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :admin_authorize
  layout 'admin'
  
  def index
    # Работа с контентом
    @users = User.all
		@title = 'Список пользователей'
    # Отображение страницы
		respond_to do |format|
			format.html
		end
	end

  # render new.rhtml
  def new
    @title = 'Добавление пользователя'
    @user = User.new
  end
 
  def create
    # Работа с контентом
		@user = User.new(params[:user])
    # Настройка страницы
		@title = 'Добавление пользователя'
    # Отображение страницы
		respond_to do |format|
  		if @user.save
    		flash[:notice] = "Фотография добавлена"
    		format.html { redirect_to(:controller=>'users') }
 			else
    		format.html { render :action => "new" }
  		end
		end
  end
end
