class Admin::PagesController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_authorize
  layout 'admin'
  
  def index
    @pages = Page.find_all_by_parent_id(0)
  end

  def new
    @page = Page.new
    @parent_pages = [['отсутствует',0]]
    # страницы первого уровня
    @pages = Page.level(1).each do |page|
      @parent_pages.push [page.title, page.id]
      # страницы второго уровня
      page.child_pages.each do |child_page|
        # страницы третьего уровня
        @parent_pages.push ['- '+child_page.title, child_page.id]
        child_page.child_pages.each do |third_page|
          @parent_pages.push ['- - '+third_page.title, third_page.id]
        end
      end
    end
    @title = 'Добавление страницы'
  end

  def edit
    @page = Page.find(params[:id])
    @parent_pages = [['отсутствует',0]]
    # страницы первого уровня
    @pages = Page.level(1).each do |page|
      @parent_pages.push [page.title, page.id]
      # страницы второго уровня
      page.child_pages.each do |child_page|
        # страницы третьего уровня
        @parent_pages.push ['- '+child_page.title, child_page.id]
        child_page.child_pages.each do |third_page|
          @parent_pages.push ['- - '+third_page.title, third_page.id]
        end
      end
    end
    @title = 'Редактирование страницы'
  end

  def create
		@page = Page.new(params[:page])
		@title = 'Добавление страницы'
		respond_to do |format|
      if @page.parent_id == 0
        @page.level = 1
      else
        @page.level =  Page.find(@page.parent_id).level+1
      end
  		if @page.save
    		flash[:notice] = "Страница добавлена"
    		format.html { redirect_to(:controller=>'pages') }
 			else
    		format.html { render :action => "new" }
  		end
		end
  end

  def update
    @page = Page.find(params[:id])
		@title = 'Редактирование страницы'
		respond_to do |format|
      if @page.parent_id == 0
        @page.level = 1
      else
        @page.level =  Page.find(@page.parent_id).level+1
      end
			if @page.update_attributes(params[:page])
		  	flash[:notice] = 'Страница изменена'
		  	format.html { redirect_to(:controller=>'pages') }
			else
		  	format.html { render :action => "edit" }
			end
		end
	end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
		respond_to do |format|
  		format.html { redirect_to(:controller=>'pages') }
		end
	end
  
end