class User < ApplicationRecord
  after_save :find_valid_email

  private

  def find_valid_email
    FindValidEmailJob.perform_later(id)
  end
end



