class UserConfigurator
  def initialize(user, platform = IuguLite::Purchaser)
    @user = user
    @platform = platform
  end

  def call
    return unless user.persisted?

    create_buyer_profile
  end

  private

  attr_reader :user, :platform

  def create_buyer_profile
    return if user.payment_token.present?

    response = platform.create(email: user.email)
    user.update(payment_token: response.token)
  end
end
