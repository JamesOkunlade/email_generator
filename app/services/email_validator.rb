class EmailValidator
    attr_reader :first_name, :last_name, :url
    attr_accessor :valid_email, :email_permutations, :completion_status

    ACCESS_KEY = '59243f6da3f4e639bb9cd59c6f2ec5b5'

    def initialize(user)
      @user = user
      @first_name = user.first_name.downcase
      @last_name = user.last_name.downcase
      @url = user.url.downcase
      self.completion_status = false
      self.email_permutations = [
          "#{first_name}.#{last_name}@#{url}",
          "#{first_name}@#{url}",
          "#{first_name}#{last_name}@#{url}",
          "#{last_name}.#{first_name}@#{url}",
          "#{first_name[0]}.#{last_name}@#{url}",
          "#{first_name[0]}#{last_name[0]}@#{url}"
        ]
    end

    def find_valid_email        
      email_permutations.each do |email|
        check_api(email) 
        break if completion_status
      end

      unless completion_status
        update_user("No valid email available!")
      end  
    end

    private

    def check_api(email)
      # The free subscription of Mailbox does not support catch_all detection
      response = HTTParty.get("https://apilayer.net/api/check?access_key=#{ACCESS_KEY}&email=#{email}")
      formatted_response = response.parsed_response
      if formatted_response["format_valid"] and formatted_response["mx_found"] and formatted_response["smtp_check"]
        update_user(email)
      end
      puts formatted_response 
      puts email
    end
    
    def update_user(email)
      @user.update_attribute :valid_email, email
      @completion_status = true
      raise StandardError 
    end
end
  




