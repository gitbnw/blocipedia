module ChargesHelper

  def stripe_btn_data(amount=3424234234234)
    {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: amount
    }
  end

end
