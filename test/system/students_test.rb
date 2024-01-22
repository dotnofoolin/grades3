require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  test "visiting the index path" do
    student = students(:random)

    visit students_path
  
    assert_selector "h1", text: "Grades Dashboard"
    assert page.has_content? student.name
    assert page.has_link? student.courses.first.name
  end
end
