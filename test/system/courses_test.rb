require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  test "visiting the show path" do
    course = courses(:random)
    visit course_path(course)
  
    assert page.has_content? course.student.name
    assert page.has_content? course.name
    assert page.has_content? course.assignments.first.name
  end
end
