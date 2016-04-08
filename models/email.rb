class Email < ActiveRecord::Base
  VALID_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def self.valid?(email)
    !(email =~ VALID_REGEX).nil?
  end

  def self.parse_domain(email)
    email.split('@').last
  end
end
