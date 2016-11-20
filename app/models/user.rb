class User < ApplicationRecord
  before_save { email.downcase! unless email.nil? }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :furigana, presence: true
  validates :nickname, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, allow_nil: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :joined, presence: true, numericality: {greater_than: 1994}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def full_name
    last_name + ' ' + first_name
  end
end