class User < ApplicationRecord
  before_save :check_records
  after_save :find_valid_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :url, presence: true

  private

  def check_records
    user_table = Arel::Table.new(:users)
    query = user_table[:first_name].matches("%#{self.first_name}%").and(user_table[:last_name].matches("%#{self.last_name}%").and(user_table[:url].matches("%#{self.url}%")))
    query.to_sql
    existing_user = User.where( query )
    self.destroy if existing_user.length > 0    
  end

  def find_valid_email
    FindValidEmailJob.perform_later(id)
  end
end





