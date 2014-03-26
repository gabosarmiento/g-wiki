class ContentController < ApplicationController
  before_filter :authenticate_user!
  
  def basic
    authorize! :view, :basic, :message => 'Access limited to Basic Plan subscribers.'
    @activities = PublicActivity::Activity.order("created_at desc").where(trackable_id: current_user.wikis, trackable_type: "Wiki")
  end

  def pro
    authorize! :view, :pro, :message => 'Access limited to Pro Plan subscribers.'
    @activities = PublicActivity::Activity.order("created_at desc").where(trackable_id: current_user.wikis, trackable_type: "Wiki")                                            
  end
end
