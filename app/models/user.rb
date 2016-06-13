class User < ActiveRecord::Base
  has_many :collections
  has_many :albums, through: :collections

  validates :username, :email, { presence: true, uniqueness: true }
  validates :password, length: {minimum: 4}, :on => :create

  has_secure_password

end