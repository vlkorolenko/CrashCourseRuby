require 'date'

class Student
  attr_reader :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = Date.parse(date_of_birth)

    raise ArgumentError, 'Date of birth must be in the past' if @date_of_birth >= Date.today

    self.class.add_student(self)
  end

  def self.add_student(student)
    unless @@students.any? { |s| s.surname == student.surname && s.name == student.name && s.date_of_birth == student.date_of_birth }
      @@students << student
    else
      raise ArgumentError, 'Duplicate student'
    end
  end

  def self.remove_student(student)
    if @@students.include?(student)
      @@students.delete(student)
    else
      raise ArgumentError, 'Student not found'
    end
  end

  def self.calculate_age(student)
    ((Date.today - student.date_of_birth).to_i / 365.25).to_i
  end

  def self.get_students_by_age(age)
    @@students.select { |s| calculate_age(s) == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |s| s.name == name }
  end

  def self.students
    @@students
  end

  def to_s
    "#{@name} #{@surname} (#{@date_of_birth})"
  end
end
