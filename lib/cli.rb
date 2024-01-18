#This will have the same info we used to create the file that was scrubbed...
require_relative "api.rb"
require_relative "user.rb"
require_relative 'auth.rb'

class CLI
  def run
    User.seed
    system("clear")
    greet
    enter_credentials
    while menu != "exit"
    end
    sign_out
    goodbye
  end

  def greet
    puts "Welcome to our Exercise"
  end

  def goodbye
    puts "Have a great day!"
  end

  def enter_credentials
    puts "Do you have an account? Type 'Y' to Sign In or 'N' to Sign Up"
    response = gets.chomp.downcase

    if response == "y"
      sign_in
    elsif response == "n"
      sign_up
    else
      puts "Invalid input. Please enter 'Y' or 'N'."
      enter_credentials
    end
  end

  def sign_up
    puts "Sign Up\n\n"
    puts "Please enter a username:"
    username = gets.chomp
    puts "Please enter a password:"
    password = gets.chomp

    if username == "" || password == ""
      puts "Invalid credentials. Please try again."
      sign_up
      return nil
    end

    User.new(username, password)
    puts "Welcome, #{username}! You have been successfully signed up."
    sign_in
  end

  def sign_in
    is_authenticated = false
    puts "Sign In\n\n"

    until is_authenticated
      puts "Please enter your username:"
      username = gets.chomp
      puts "Please enter your password:"
      password = gets.chomp

      is_authenticated = Auth.authenticate_user(username, password, User.all)

      if is_authenticated
        puts "Welcome #{username}!"
      else
        puts "Invalid credentials. Please try again."
      end
    end
  end

  def menu
    puts "Do you need to change your password? Type 'Y' to change or 'N' to continue"
    response = gets.chomp.downcase
    if response == "y"
      change_password
    elsif response == "n"
      puts "Thank you for using our app!"
      exit
    else
      puts "Invalid input. Please enter 'Y' or 'N'."
      menu
    end
  end
  def sign_out
    puts "Goodbye #{@curr_user.username}!"
  end
end
