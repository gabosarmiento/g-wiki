class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end  

  def after_sign_in_path_for(resource)
    case current_user.role
      when 'admin'
        user_path(current_user)
      when 'free'
        user_path(current_user)
      when 'basic'
        content_basic_path
      when 'pro'
        content_pro_path
      else
        root_path
    end
  
  end

  def after_sign_out_path_for(resource_or_scope)
  root_path
  end

end

