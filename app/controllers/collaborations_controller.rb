class CollaborationsController < ApplicationController
  respond_to :html, :js 
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborations = Wiki.find(params[:wiki_id]).collaborations
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = @wiki.collaborations.new
    @user = User.all
  end

  def create
    @wiki = Wiki.find(params[:wiki_id]) 
    @user = User.find(params[:user_ids])
    @collaborations = @wiki.collaborations.create(user_id: @user.id)
    if @collaborations.save
      flash[:notice] = "Collaborator was saved."
      redirect_to @wiki
    else
    flash[:error] = "There was an error saving the collaborator. Please try again."
      redirect_to :new
    end
  end

  def destroy 
     @collaboration = Collaboration.find(params[:id])
    if @collaboration.destroy
      flash[:notice] = "Removed collaborator"
      redirect_to :back
    else
      flash[:error] = "Unable to remove collaborator. Please try again."
      redirect_to :back
    end
  end

end
