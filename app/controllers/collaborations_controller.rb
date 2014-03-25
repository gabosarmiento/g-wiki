class CollaborationsController < ApplicationController
  respond_to :html, :js 
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborations = Wiki.find(params[:wiki_id]).collaborations
    authorize! :read, @wiki, message: "You are not allowed to see Collaborators."
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaboration = @wiki.collaborations.new
    @user = User.all
    authorize! :destroy, @wiki, message: "You are not allowed create Collaborators."
  end

  def create
    @wiki = Wiki.find(params[:wiki_id]) 
    @user = User.find(params[:collaboration][:user_id])
    @collaborations = @wiki.collaborations.create(user_id: @user.id)
    authorize! :destroy, @wiki, message: "You need to be a own this wiki to add a collaborator."
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
      authorize! :destroy, Collaboration, message: "You need to own the wiki to delete collaborators."
    if @collaboration.destroy
      flash[:notice] = "Removed collaborator"
      redirect_to :back
    else
      flash[:error] = "Unable to remove collaborator. Please try again."
      redirect_to :back
    end
  end

end