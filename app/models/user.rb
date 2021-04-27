class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create_commit :configurate_buyer_profile

  def configurate_buyer_profile
    UserConfigurator.new(self).call
  rescue StandardError
    Rails.logger.error I18n.t('user.purchaser_error')
  end
end
