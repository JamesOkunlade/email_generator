class FindValidEmailJob < ApplicationJob
    queue_as :default

    # discard_on(StandardError) do |job, error|
    #   ExceptionNotifier.caught(error)
    # end
    rescue_from(ActiveRecord::RecordNotFound) do |exception|
      puts "Will try again soon"
    end

    def perform(user_id)
      user = User.find(user_id)
      EmailValidator.new(user).check
    end
end
  