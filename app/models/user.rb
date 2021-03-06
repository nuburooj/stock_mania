class User < ApplicationRecord
    attr_reader :password

    validates :first_name, :last_name, :password_digest, presence: true
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 8}, allow_nil: true

    after_initialize :ensure_session_token

    #FIGVAPER

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil unless user
        user.is_password?(password) ? user : nil
    end
    
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password_obj = BCrypt::Password.new(self.password_digest)
        password_obj.is_password?(password)
    end

    def generate_session_token 
        SecureRandom.urlsafe_base64(16)
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save
        self.session_token
    end
end
