require 'bcrypt'

module Auth
  def self.create_hash_digest(password)
    BCrypt::Password.create(password)
  end

  def self.verify_hash_digest(hash_password, plain_password)
    BCrypt::Password.new(hash_password) == plain_password
  end

  def self.authenticate_user(username, password, list_of_users)
    list_of_users.each do |user_record|
      found_user = user_record.username == username
      hash_password = user_record.password
      match_password = verify_hash_digest(hash_password, password)

      return user_record if found_user && match_password
    end
    nil
  end
end
