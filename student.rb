require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end
end

  def play_hooky
    '¯\\_(ツ)_/¯'
  end
end
