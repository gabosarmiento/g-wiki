class WikisController < ApplicationController
  respond_to :html, :js

  def index
    if params[:query].present?
      @wikis = Wiki.search(params[:query], load: true)
    elsif params[:tag]
      @wikis = Wiki.visible_to(current_user).tagged_with(params[:tag])
    else
      @wikis = Wiki.visible_to(current_user)
    end 
    authorize! :read, Wiki, message: "You can't see private wikis"
  end

  def new
    @wiki = Wiki.new  
    authorize! :create, @wiki, message: "You need to be a member to create a new wiki."
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize! :read, @wiki, message: "You are not allowed to see this private wiki."
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize! :edit, Wiki, message: "You need to be a member to update a new wiki."
  end

  def create
    @wiki = current_user.wikis.build(params[:wiki], load: true)
    authorize! :create, @wiki, message: "You need to have a subscription to do that."
    if @wiki.save
      name = @wiki.wikiname
      undo_link = view_context.link_to("undo \"#{name}\"", uncreate_version_path(@wiki.versions.scoped.last), :method => :post)
      flash[:notice] = "Wiki was saved. #{undo_link}"
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
      #@wiki.update_attribute(:user_id, current_user.id ) # an User could own someone else's wiki by modifying it
      flash[:notice] = "Wiki was updated. #{undo_link}"
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
      flash[:notice] = "\"#{name}\" was deleted successfully. #{undo_link}"
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

  private
  def undo_link
  view_context.link_to("undo", revert_version_path(@wiki.versions.scoped.last), :method => :post)
  end
end
