class EmailValidator
    attr_reader :first_name, :last_name, :url
    attr_accessor :valid_email, :valid_email_available, :email_permutations

    def initialize(user)
        @user      = user
        @first_name   = user.first_name.downcase
        @last_name   = user.last_name.downcase
        @url   = user.url.downcase
        @valid_email_available = false
        @email_permutations = [
            "#{first_name}.#{last_name}@#{url}",
            "#{first_name}@#{url}",
            "#{first_name}#{last_name}@#{url}",
            "#{last_name}.#{first_name}@#{url}",
            "#{first_name[0]}.#{last_name}@#{url}",
            "#{first_name[0]}#{last_name[0]}@#{url}"
        ]
    end

    def find_valid_email
        @email_permutations.each do |email|
            check_api(email) 
            # break if valid_email_available
        end

        unless valid_email_available
            update_user("No valid email available!")
        end
    end

    private

    def check_api(email)
        response = HTTParty.get("https://apilayer.net/api/check?access_key=d0ea522ae2832ccb5b48f17e91f8d179&email=#{email}")
        formatted_response = response.parsed_response
        if formatted_response["format_valid"] and formatted_response["mx_found"] and formatted_response["smtp_check"]
            update_user(email)
            @valid_email_available = true
        end
        puts formatted_response
    end
    
    def update_user(email)
        @user.update_attribute :valid_email, email
        raise StandardError
    end
end
  




