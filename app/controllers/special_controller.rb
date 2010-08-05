class SpecialController < ApplicationController
  before_filter :init_page

  def index
    @photos = Photo.all(:conditions=>['in_voting',true])
    respond_to do |format|
      format.html
    end
  end
  def vote
    respond_to do |format|
      voted = Vote.find_by_user_ip(request.ip)
      if voted
        format.js {render :text=>'Вы уже голосовали'}
      else
        params[:vote][:user_ip] = request.ip
        vote = Vote.new(params[:vote])
        if vote.valid?
          vote.save
          format.js {render :text=>'Ваш голос учтен'}
        else
          format.js {render :text=>'Заполните все поля'}
        end
      end
    end
  end
end
