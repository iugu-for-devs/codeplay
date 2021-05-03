class CompanyToken < ApplicationRecord
  validates :token, presence: true
  def self.current_token
    return first.token if any?

    nil
  end
end
