class User < ApplicationRecord
  after_save :find_valid_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :url, presence: true

  private

  def find_valid_email
    FindValidEmailJob.perform_later(id)
  end
end



