require 'date'
require_relative 'Student'

def test_future_date_of_birth
  Student.students.clear

  begin
    Student.new("Korolenko", "Vlad", "2025-11-11")
    raise "Fail: No error raised for future date of birth"
  rescue ArgumentError => ex
    raise "Fail: Incorrect error message" if ex.message != 'Date of birth must be in the past'
  end

  puts "Future birth date passed"
end

def test_add_student
  Student.students.clear

  student = Student.new("Korolenko", "Vlad", "2005-11-01")
  raise "Fail: nique student not added" if Student.students.size != 1

  begin
    Student.new("Korolenko", "Vlad", "2005-11-01")
    raise "Fail: No error raised for duplicate student"
  rescue ArgumentError => ex
    raise "Fail: Incorrect error message" if ex.message != 'Duplicate student'
  end

  puts "Add student passed"
end

def test_remove_student
  Student.students.clear

  student = Student.new("Korolenko", "Vlad", "2005-11-01")
  Student.remove_student(student)

  raise "Fail: Student not removed" if Student.students.size != 0

  begin
    Student.remove_student(student)
    raise "Fail: No error raised for removing non-existing student"
  rescue ArgumentError => ex
    raise "Fail: Incorrect error message" if ex.message != 'Student not found'
  end

  puts "Remove student passed"
end

def test_calculate_age
  Student.students.clear

  student = Student.new("Korolenko", "Vlad", "2005-11-01")
  expected_age = Date.today.year - 2005
  raise "Fail: Incorrect age calculation" if Student.calculate_age(student) != expected_age

  puts "Calculate age passed"
end

def test_get_students_by_age
  Student.students.clear

  student = Student.new("Korolenko", "Vlad", "2005-11-01")
  age = Date.today.year - 2005
  raise "Fail: Incorrect students by age" unless Student.get_students_by_age(age).include?(student)

  puts "Get student by age passed"
end

def test_get_students_by_name
  Student.students.clear

  student = Student.new("Korolenko", "Vlad", "2005-11-01")
  raise "Fail: Incorrect students by name" unless Student.get_students_by_name("Vlad").include?(student)

  puts "Get student by name passed"
end

test_future_date_of_birth
test_add_student
test_remove_student
test_calculate_age
test_get_students_by_age
test_get_students_by_name
