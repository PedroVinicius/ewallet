class User < Sequel::Model(:users)
  include BCrypt

  def password(password)
    self.encrypted_password
  end
  
  def password=(password)
    self.encrypted_password = BCrypt::Password.create(password)
  end
end