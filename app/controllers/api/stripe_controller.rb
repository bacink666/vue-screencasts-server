Stripe.api_key = 'sk_test_Hps7yIGXMTwzBFh9pTsci6wy'

class Api::StripeController < ApplicationController
  def create_session_id
    session = Stripe::Checkout::Session.create(
      customer_email: current_user && current_user.email,
      payment_method_types: ['card'],
      subscription_data: {
        items: [{
          plan: params[:plan_id]
        }]
      },
      success_url: "#{ENV['BASE_URL']}/subscription_success",
      cancel_url: "#{ENV['BASE_URL']}/pro"
    )
    render json: {session_id: session.id}
  end
end