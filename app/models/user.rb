class User < ActiveRecord::Base
  validates :username, :session_token, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :password, allow_nil: true, length: { minimum: 6 }

  attr_reader :password

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest) == password
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
  end


  def find_by_credentials(opts)
    user = User.find_by(username: opts[:username])
    if user
      return user if user.is_password(opts[:password])
    end
    nil
  end


end
