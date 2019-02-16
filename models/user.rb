class User < Sequel::Model(:users)
  include BCrypt

  one_to_many :accounts

  def password(password)
    self.encrypted_password
  end
  
  def password=(password)
    self.encrypted_password = BCrypt::Password.create(password)
  end

  def authenticate(password)
    actual_password = BCrypt::Password.new(self.encrypted_password)
    actual_password == password
  end
end