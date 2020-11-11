class FindValidEmailJob < ApplicationJob
    queue_as :default

    discard_on StandardError
    # rescue_from StandardError do
    #   retry_job wait: wait.seconds, queue: :default, retries_count: retries_count if retries_count < 2
    # end
  
    def perform(user_id)
      user = User.find(user_id)
      EmailValidator.new(user).find_valid_email
    end
end
  