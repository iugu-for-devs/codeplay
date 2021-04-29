class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  store_accessor :address, :street, :number, :zipcode, :complement, :state, :city
  validates :full_name, :address, :birthdate, :cpf, presence: true

  after_create_commit :configurate_buyer_profile

  private

  def configurate_buyer_profile
    UserConfigurator.new(self).call
  rescue StandardError
    Rails.logger.error I18n.t('user.purchaser_error')
  end
end
