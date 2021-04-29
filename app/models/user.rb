class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  store_accessor :address, :street, :number, :zipcode, :complement, :state, :city
  validates :full_name, :address, :birthdate, :cpf, presence: true
end
