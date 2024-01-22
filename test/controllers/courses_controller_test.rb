require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    course = courses(:random)
    
    get course_path(course)
    assert_response :success
  end
end
