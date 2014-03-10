class ChargesController < ApplicationController
   def new
    # Because large hashes in haml are no fun
    @stripe_btn_hash = {
      src: "https://checkout.stripe.com/checkout.js", 
      class: 'stripe-button',
      data: {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "G-WIKI Membership - #{current_user.username}",
        amount: 9_000_000_000_00 # We're like the Snapchat for Wikipedia
      }
    }
  end

  def create
    @amount = params[:amount]

    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "G-WIKI Membership - #{current_user.username}",
      currency: 'usd'
    )

    flash[:success] = "Thanks for all the money, #{current_user.username}! Feel free to pay me again."
    redirect_to user_path(current_user) # or wherever

  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
