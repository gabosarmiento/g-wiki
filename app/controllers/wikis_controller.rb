class WikisController < ApplicationController
  def index
    @wiki = Wiki.visible_to(current_user)
  end

  def new
    @wiki = Wiki.new  
    authorize! :create, Wiki, message: "You need to be a member to create a new wiki."
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize! :edit, Wiki, message: "You need to be a member to update a new wiki."
  end

  def create
    @wiki = current_user.wikis.build(params[:wiki])
    authorize! :create, @wiki, message: "You need to be signed up to do that."
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
    flash[:error] = "There was an error saving the wiki. Please try again."
    render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize! :update, @wiki, message: "You need to be signed up to do that."
    if @wiki.update_attributes(params[:wiki])
      #@wiki.update_attribute(:user_id, current_user.id ) => an User could own someone else's wiki by modifying it
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    name = @wiki.wikiname
    authorize! :destroy, @wiki, message: "You need to own the wiki to delete it."
    if @wiki.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

  def hide
  end
end