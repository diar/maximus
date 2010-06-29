class SpecialController < ApplicationController
  def index
    @photos = Photo.all
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
        vote.save
        format.js {render :text=>'Ваш голос учтен'}
      end
    end
  end
end
