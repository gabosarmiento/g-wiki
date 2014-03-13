class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end  

  def after_sign_in_path_for(resource)
  user_path(current_user)
  end

  def after_sign_out_path_for(resource_or_scope)
  root_path
  end

  def stripe_btn_hash
    @stripe_btn_hash = {
      src: "https://checkout.stripe.com/checkout.js", 
      class: 'stripe-button',
      data: {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "G-WIKI Membership - #{current_user.username}",
        amount: 500 
      }
    }
  end
end

