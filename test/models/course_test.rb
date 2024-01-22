require "test_helper"

class CourseTest < ActiveSupport::TestCase
  setup do
    @course = courses(:random)
  end

  test 'can create new Course' do
    course = Course.new(
      student: students(:random),
      name: Faker::Educator.course_name,
      average: Faker::Number.within(range: 0.0..100.0),
      last_update: Faker::Date.in_date_period(month: 2)
    )
    
    assert_nothing_raised { course.save }
    assert course.valid?
  end

  test '#grade returns A' do
    @course.update(average: 95.00)
    assert_equal 'A', @course.grade
  end

  test '#grade returns B' do
    @course.update(average: 85.00)
    assert_equal 'B', @course.grade
  end

  test '#grade returns C' do
    @course.update(average: 75.00)
    assert_equal 'C', @course.grade
  end

  test '#grade returns D' do
    @course.update(average: 65.00)
    assert_equal 'D', @course.grade
  end

  test '#grade returns F' do
    @course.update(average: 55.00)
    assert_equal 'F', @course.grade
  end

  test '#last_update_formatted returns formatted string' do
    expected = @course.last_update_formatted
    assert_instance_of String, expected
    assert_equal expected, @course.last_update.strftime('%m/%d/%Y')
  end

  test '#last_update_formatted returns nil if last_update is nil' do
    @course.update(last_update: nil)
    assert_nil @course.last_update_formatted
  end

  test '#health_bar_color_class returns correct value when grade is A' do
    @course.update(average: 95.00)
    assert_equal 'is-success', @course.health_bar_color_class
  end

  test '#health_bar_color_class returns correct value when grade is B' do
    @course.update(average: 85.00)
    assert_equal 'is-primary', @course.health_bar_color_class
  end

  test '#health_bar_color_class returns correct value when grade is C' do
    @course.update(average: 75.00)
    assert_equal 'is-info', @course.health_bar_color_class
  end

  test '#health_bar_color_class returns correct value when grade is D' do
    @course.update(average: 65.00)
    assert_equal 'is-warning', @course.health_bar_color_class
  end

  test '#health_bar_color_class returns correct value when grade is F' do
    @course.update(average: 55.00)
    assert_equal 'is-danger', @course.health_bar_color_class
  end
end
