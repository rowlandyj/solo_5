require 'bcrypt'
class User < ActiveRecord::Base
  attr_reader :entered_password
  validates :username, uniqueness: true
  validates :entered_password, :length => { minimum: 6 }

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @entered_password = new_password
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
