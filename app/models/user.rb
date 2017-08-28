class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: { message: 'Password can\'t be blank.' }
  validates :session_token, presence: true

  attr_reader :password

  before_validation :ensure_session_token

  has_many :goals,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Goal

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token

    while User.exists?(session_token: self.session_token)
      self.session_token = self.class.generate_session_token
    end
    self.save!

    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
