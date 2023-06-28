# people_controller.rb
require_relative 'person'
require_relative 'teacher'
require_relative 'student'

class PeopleController
  def initialize(interface)
    @interface = interface
    @people = []
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

  def select_person
    @interface.print_message('Select a person from the following list by number (not id)')
    @people.each_with_index do |person, index|
      @interface.print_message("#{index}) [#{person.class}]: Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}")
    end
    person_index = @interface.get_input.to_i
    @people[person_index]
  end

  private

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
end
