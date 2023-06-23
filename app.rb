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

end
