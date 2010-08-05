class PagesController < ApplicationController
  before_filter :init_page

  def show
    @page = @current_page
  end
end
