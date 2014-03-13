class MyWikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).where(:user_id => current_user.id)
    @pwikis = @wikis.where(:public => false)
  end

  def show
    @wiki = Wiki.find(params[:user_id])
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end
end