class FindValidEmailJob < ApplicationJob
    queue_as :urgent

    discard_on(StandardError) do |job, error|
      ExceptionNotifier.caught(error)
    end

    def perform(user_id)
      user = User.find(user_id)
      EmailValidator.new(user).find_valid_email
    end
end
  