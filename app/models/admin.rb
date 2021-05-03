class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, format: { with: /\A[a-zA-Z0-9_.+-]+@codeplay.com.br\z/,
                              message: 'Domínio não válido!' }
  has_many :courses, dependent: :nullify
end
