class CollaborationsController < ApplicationController

  def show
    @collaboration = Wiki.find(params[:id]).collaborations
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborations = current_user.collaborations.create(wiki_id: @wiki.id)
    if @collaborations.save
      flash[:notice] = "Collaborator was saved."
      redirect_to @wiki
    else
    flash[:error] = "There was an error saving the collaborator. Please try again."
      redirect_to @wiki 
    end
  end

  def destroy 
     @collaborations = current_user.collaborations.find(params[:id])
    if @collaborations.destroy
      flash[:notice] = "Removed collaborator"
      redirect_to wiki_path
    else
      flash[:error] = "Unable to remove collaborator. Please try again."
      redirect_to wiki_path
    end
  end

end
