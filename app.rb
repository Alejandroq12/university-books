require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    puts "Welcome to School Library App!\n\n"
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = gets.chomp.to_i

    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'

    rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
      puts
    end
  end

  def list_all_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    puts
  end

  def list_all_people
    @people.each do |person|
      puts "Type: #{person.class}, Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [input number]: '
    choice = gets.chomp

    case choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid option'
      return
    end
    puts 'Person created successfully'
    puts
  end

  def create_student
    age = nil
    loop do
      print 'Age: '
      age = gets.chomp
      break if age.match?(/^\d+$/) # checks if the input contains only digits

      puts 'Invalid age. Please enter a valid number.'
    end

    print 'Name: '
    name = gets.chomp

    parent_permission = nil
    loop do
      print 'Has parent permission? [Y/N]: '
      parent_permission = gets.chomp.downcase
      break if %w[y n].include?(parent_permission)

      puts 'Invalid input. Please enter Y for Yes or N for No.'
    end

    @people << Student.new(age.to_i, name, parent_permission: parent_permission == 'y')
  end

  def create_teacher
    age = nil
    loop do
      print 'Age: '
      age = gets.chomp
      break if age.match?(/^\d+$/) # checks if the input contains only digits

      puts 'Invalid age. Please enter a valid number.'
    end

    print 'Name: '
    name = gets.chomp
    name = 'Unknown' if name.empty?

    print 'Specialization: '
    specialization = gets.chomp

    @people << Teacher.new(age.to_i, name, specialization)
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created successfully'
    puts
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}]: Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
    puts
  end

  def handle_option(choice)
    options = {
      '1' => method(:list_all_books),
      '2' => method(:list_all_people),
      '3' => method(:create_person),
      '4' => method(:create_book),
      '5' => method(:create_rental),
      '6' => method(:list_rentals_for_person_id),
      '7' => proc {
               puts 'Thank you for using this app!'
               exit
             }
    }

    if options[choice]
      options[choice].call
    else
      puts 'Invalid option'
    end
  end

  def main
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    choice = gets.chomp

    handle_option(choice)
    main
  end
end
