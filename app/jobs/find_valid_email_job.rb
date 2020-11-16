class FindValidEmailJob < ApplicationJob
    queue_as :default

    def perform(user_id)
      user = User.find(user_id)
      EmailValidator.new(user).check
    end
end
  