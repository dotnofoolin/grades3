require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  setup do
    @assignment = assignments(:random)
  end

  test 'can create new Assignment' do
    assignment = Assignment.new(
      student: students(:random),
      course: courses(:random),
      due_date: Faker::Date.in_date_period(month: 2),
      date_assigned: Faker::Date.in_date_period(month: 2),
      name: Faker::Educator.course_name,
      category: %w[Classwork Participation Test].sample,
      score: Faker::Number.number(digits: 2),
      total_points: Faker::Number.number(digits: 2)
    )
    
    assert_nothing_raised { assignment.save }
    assert assignment.valid?
  end

  test '#due_date_formatted returns formatted string' do
    expected = @assignment.due_date_formatted
    assert_instance_of String, expected
    assert_equal expected, @assignment.due_date.strftime('%m/%d/%Y')
  end

  test '#due_date_formatted returns nil if last_update is nil' do
    @assignment.update(due_date: nil)
    assert_nil @assignment.due_date_formatted
  end

  test '#date_assigned_formatted returns formatted string' do
    expected = @assignment.date_assigned_formatted
    assert_instance_of String, expected
    assert_equal expected, @assignment.date_assigned.strftime('%m/%d/%Y')
  end

  test '#date_assigned_formatted returns nil if last_update is nil' do
    @assignment.update(date_assigned: nil)
    assert_nil @assignment.date_assigned_formatted
  end

  test '#average returns correct value when total_points is greater than 0' do
    @assignment.update(score: 50.0, total_points: 100.0)
    expected = @assignment.average
    assert_instance_of Float, expected
    assert_equal 50.0, expected
  end

  test '#average returns correct value when total_points is 0' do
    @assignment.update(score: 50.0, total_points: 0.0)
    expected = @assignment.average
    assert_instance_of Float, expected
    assert_equal 100.0, expected
  end

  test '#grade returns correct value when expecting an A' do
    @assignment.update(score: 90.0, total_points: 100.0)
    expected = @assignment.grade
    assert_instance_of String, expected
    assert_equal 'A', expected
  end

  test '#grade returns correct value when expecting an B' do
    @assignment.update(score: 80.0, total_points: 100.0)
    expected = @assignment.grade
    assert_instance_of String, expected
    assert_equal 'B', expected
  end

  test '#grade returns correct value when expecting an C' do
    @assignment.update(score: 70.0, total_points: 100.0)
    expected = @assignment.grade
    assert_instance_of String, expected
    assert_equal 'C', expected
  end

  test '#grade returns correct value when expecting an D' do
    @assignment.update(score: 60.0, total_points: 100.0)
    expected = @assignment.grade
    assert_instance_of String, expected
    assert_equal 'D', expected
  end

  test '#grade returns correct value when expecting an F' do
    @assignment.update(score: 50.0, total_points: 100.0)
    expected = @assignment.grade
    assert_instance_of String, expected
    assert_equal 'F', expected
  end

end
