require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'
require_relative 'console_interface'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    @interface = ConsoleInterface.new
    @interface.print_welcome_message
  end

  def run
    loop do
      @interface.print_options
      choice = @interface.get_input
      handle_option(choice)
    end
  end

  def list_rentals_for_person_id
    @interface.print_message('ID of person: ')
    id = @interface.get_input.to_i

    rentals = @rentals.filter { |rental| rental.person.id == id }
    @interface.print_message('Rentals:')

    rentals.each do |rental|
      @interface.print_message("Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}")
    end
  end

  def list_all_books
    @books.each { |book| @interface.print_message("Title: \"#{book.title}\", Author: #{book.author}") }
  end

  def list_all_people
    @people.each do |person|
      @interface.print_message("Type: #{person.class}, Name: #{person.name}, ID: #{person.id}, Age: #{person.age}")
    end
  end

  def create_person
    @interface.print_message('Do you want to create a student (1) or a teacher (2)? [input number]: ')
    choice = @interface.get_input

    case choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      @interface.print_message('Invalid option')
      return
    end
    @interface.print_message('Person created successfully')
  end

  def create_person_info
    age = nil
    loop do
      @interface.print_message('Age: ')
      age = @interface.get_input
      break if age.match?(/^\d+$/)

      @interface.print_message('Invalid age. Please enter a valid number.')
    end

    @interface.print_message('Name: ')
    name = @interface.get_input

    [age.to_i, name]
  end

  def create_student
    age, name = create_person_info

    parent_permission = nil
    loop do
      @interface.print_message('Has parent permission? [Y/N]: ')
      parent_permission = @interface.get_input.downcase
      break if %w[y n].include?(parent_permission)

      @interface.print_message('Invalid input. Please enter Y for Yes or N for No.')
    end

    @people << Student.new(age, name, parent_permission: parent_permission == 'y')
  end

  def create_teacher
    age, name = create_person_info

    @interface.print_message('Specialization: ')
    specialization = @interface.get_input

    @people << Teacher.new(age, name, specialization)
  end

  def create_book
    @interface.print_message('Title: ')
    title = @interface.get_input

    @interface.print_message('Author: ')
    author = @interface.get_input

    @books << Book.new(title, author)
    @interface.print_message('Book created successfully')
  end

  def create_rental
    @interface.print_message('Select a book from the following list by number')
    @books.each_with_index do |book, index|
      @interface.print_message("#{index}) Title: \"#{book.title}\", Author: #{book.author}")
    end
    book_index = @interface.get_input.to_i

    @interface.print_message('Select a person from the following list by number (not id)')
    @people.each_with_index do |person, index|
      @interface.print_message("#{index}) [#{person.class}]: Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}")
    end
    person_index = @interface.get_input.to_i

    @interface.print_message('Date: ')
    date = @interface.get_input

    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    @interface.print_message('Rental created successfully')
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
               @interface.print_message('Thank you for using this app!')
               exit
             }
    }

    if options[choice]
      options[choice].call
    else
      @interface.print_message('Invalid option')
    end
  end
end
