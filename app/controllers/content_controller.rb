class ContentController < ApplicationController
  before_filter :authenticate_user!
  
  def basic
    authorize! :view, :basic, :message => 'Access limited to Basic Plan subscribers.'
    @activities = PublicActivity::Activity.order("created_at desc") #.where(owner_id: current_user, owner_type: "User")
  end

  def pro
    authorize! :view, :pro, :message => 'Access limited to Pro Plan subscribers.'
    @activities = PublicActivity::Activity.order("created_at desc") #.where(owner_id: current_user, owner_type: "User")                                             
  end
end
