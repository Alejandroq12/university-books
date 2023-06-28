# rentals_controller.rb
require_relative 'rental'

class RentalsController
  def initialize(interface, books_controller, people_controller)
    @interface = interface
    @books_controller = books_controller
    @people_controller = people_controller
    @rentals = []
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

  def create_rental
    book = @books_controller.select_book
    person = @people_controller.select_person

    @interface.print_message('Date: ')
    date = @interface.get_input

    @rentals << Rental.new(date, book, person)
    @interface.print_message('Rental created successfully')
  end
end
