class MyWikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).where(:user_id => current_user.id)
  end

  def show
    @wiki = Wiki.find(params[:user_id])
  end
end