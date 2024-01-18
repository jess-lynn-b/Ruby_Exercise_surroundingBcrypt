require_relative 'auth.rb'

class User
  # ---- setup attributes ----
  #class variables that hold all users
  @@users = []

  # make username, password, id accesible
  attr_accessor :username, :password, :id
  
  #  ----- methods ----- 
  # initialize -username, password
  def initialize(username, password)
    @username = username
    @password = Auth.create_hash_digest(password)
    # auto increnting based on the number of users in class
    @id = @@users.length() + 1
    @@users << self
  end
  # returns all users
  def self.all
    @@users
  end
  # seed - create a users(s)
  def self.seed
    users = [{ username: "joe123", password: "password1" }, { username: "amy123", password: "password2" }]

    users.each do |user|
      User.new(user[:username], user[:password])
    end
  end
  # find a user by id 
  def self.find(id)
    all.find { | user| user .id == id }
  end
end
  