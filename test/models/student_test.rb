require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test 'can create new Student' do
    student = Student.new(
      student_id: Faker::Alphanumeric.alphanumeric(number: 20),
      name: Faker::Name.name
    )
    
    assert_nothing_raised { student.save }
    assert student.valid?
  end
end
