# require 'spec_helper'
# describe Charges do
#   setup do
#    Stripe.api_key = 'sk_fake_test_key'
#   end

#   it "should post create" do
#     token = 'tok_123456'
#     email = 'foo@example.com'
#     username = 'foo'

#   Stripe::Customer.expect(:create).with({
#       email: email,
#       card: token,
#     }
#   ).returns(mock)

#   Stripe::Charge.expect(:create).with({
#     customer:    Customer.id,
#     amount:      500,
#     currency:    'usd',
#     card:        token,
#     description: 'G-WIKI Membership - foo'
#   }).returns(mock)

#   post :create

#   assert_not_nil assigns(:sale)
#   assert_equal user.id, assigns(:sale).user_id
#   assert_equal email, assigns(:sale).email
#   end

# end
