class MyWikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).where(:user_id => current_user.id)
    @pwikis = @wikis.where(:public => false)
    authorize! :read, Wiki, message: "You can't see private wikis"
  end

  def show
    @wiki = Wiki.find(params[:user_id])
    authorize! :read, @wiki, message: "You are not allowed to see this private wiki."
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end
end