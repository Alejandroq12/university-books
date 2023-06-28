require_relative 'book'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'
require_relative 'console_interface'
require_relative 'books_controller'
require_relative 'people_controller'
require_relative 'rentals_controller'

class App
  def initialize
    @interface = ConsoleInterface.new
    @books_controller = BooksController.new(@interface)
    @people_controller = PeopleController.new(@interface)
    @rentals_controller = RentalsController.new(@interface, @books_controller, @people_controller)
    @interface.print_welcome_message
  end

  def run
    loop do
      @interface.print_options
      choice = @interface.get_input
      handle_option(choice)
    end
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

  def list_all_books
    @books_controller.list_all_books
  end

  def list_all_people
    @people_controller.list_all_people
  end

  def create_person
    @people_controller.create_person
  end

  def create_book
    @books_controller.create_book
  end

  def create_rental
    @rentals_controller.create_rental
  end

  def list_rentals_for_person_id
    @rentals_controller.list_rentals_for_person_id
  end
end
