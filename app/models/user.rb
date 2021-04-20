class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :email, format: { with: /
                                    \A^([\w.-]+)@(\[(\d{1,3}\.){3}|
                                    (?!hotmail|gmail|googlemail|yahoo|gmx|ymail|outlook|bluewin|
                                    protonmail|t-online|web\.|online\.|aol\.|live\.)(([a-zA-Z\d-]+\.)+))
                                    ([a-zA-Z]{2,4}|\d{1,3})(\]?)$\z
                                    /x,
                              message: 'Email não é válido' }
end
