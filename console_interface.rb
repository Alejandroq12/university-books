class ConsoleInterface
  def print_welcome_message
    puts "Welcome to School Library App!\n\n"
  end

  def print_options
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def print_message(message)
    puts message
  end

  def get_input
    gets.chomp
  end
end
