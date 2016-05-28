class User < ActiveRecord::Base
  has_many :collections
  has_many :albums, through: :collections

  validates :username, :email, { presence: true, uniqueness: true }
  validates :hashed_password, { presence: true }

  # def password
  #   @hashed_password ||= BCrypt::Password.new(hashed_password)
  # end

  # def password=(plaintext_password)
  #   @plaintext_password = plaintext_password
  #   @password = BCrypt::Password.create(plaintext_password)
  #   self.hashed_password = @password
  # end

  # def authenticate(password)
  #   self.password == password
  # end
end