module Spree
  class Gateway::RazorpayGateway < Gateway
    preference :key_id, :string
    preference :key_secret, :string

    def provider_class
      ActiveMerchant::Billing::RazorpayGateway
    end

    def method_type
      'razorpay'
    end

    def payment_profiles_supported?
      true
    end

    def purchase(money, creditcard, gateway_options)
      provider.purchase(*options_for_purchase_or_auth(money, creditcard, gateway_options))
    end

    def authorize(money, creditcard, gateway_options)
      provider.authorize(*options_for_purchase_or_auth(money, creditcard, gateway_options))
    end

    def credit(money, creditcard, response_code, gateway_options)
      provider.refund(money, response_code, {})
    end

    def void(response_code, creditcard, gateway_options)
      provider.void(response_code, {})
    end

    def create_profile(payment)
    end

    private

    def options_for_purchase_or_auth(money, creditcard, gateway_options)
      options = gateway_options.dup
      payment = creditcard.gateway_payment_profile_id
      return money, payment, options
    end

  end
end
