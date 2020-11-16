class User < ApplicationRecord
  before_save :check_records
  after_save :find_valid_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :url, presence: true

  private

  def check_records
    existing_user = User.find_by(first_name: self.first_name, last_name: self.last_name, url: self.url)
    self.destroy if existing_user and existing_user.valid_email
  end

  def find_valid_email
    FindValidEmailJob.perform_later(id)
  end
end



