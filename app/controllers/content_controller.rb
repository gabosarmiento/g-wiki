class ContentController < ApplicationController
  before_filter :authenticate_user!
  
  def basic
    authorize! :view, :basic, :message => 'Access limited to Basic Plan subscribers.'
  end

  def pro
    authorize! :view, :pro, :message => 'Access limited to Pro Plan subscribers.'
  end
end
