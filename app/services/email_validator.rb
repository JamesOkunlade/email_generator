class EmailValidator
  require 'open-uri'

    attr_reader :first_name, :last_name, :url
    attr_accessor :valid_email, :email_permutations

    ACCESS_KEY = 'ce00f8e85eb216ef9b776cd1177e6126'

    def initialize(user)
      @user = user
      @first_name = user.first_name.downcase
      @last_name = user.last_name.downcase
      @url = user.url.downcase
      self.email_permutations = [
          "#{first_name}.#{last_name}@#{url}",
          "#{first_name}@#{url}",
          "#{first_name}#{last_name}@#{url}",
          "#{last_name}.#{first_name}@#{url}",
          "#{first_name[0]}.#{last_name}@#{url}",
          "#{first_name[0]}#{last_name[0]}@#{url}"
        ]
    end

    def check
      validate_url(url) ? find_valid_email : update_user("Invalid url")
    end
    
    def validate_url(url)
      open("https://#{url}").status
    rescue 
      false
    end
    
    def find_valid_email        
      email =
        email_permutations.find do |email|
          response = check_api(email)
          response["format_valid"] and response["mx_found"] and response["smtp_check"] 
        end
      
      if email
        update_user(email)
      else
        update_user("No valid email available")
      end
    end

    private

    def check_api(email)
      # The free subscription of Mailbox does not support catch_all detection
      response = HTTParty.get("https://apilayer.net/api/check?access_key=#{ACCESS_KEY}&email=#{email}")
      formatted_response = response.parsed_response
      puts email
      formatted_response
    end
    
    def update_user(email)
      @user.update_columns(valid_email: email)
      raise StandardError 
    end
end
  




