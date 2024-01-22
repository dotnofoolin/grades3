class Assignment < ApplicationRecord
  belongs_to :student
  belongs_to :course

  include GradeLetter

  def due_date_formatted
    return nil if due_date.blank?
    due_date.strftime('%m/%d/%Y')
  end

  def date_assigned_formatted
    return nil if date_assigned.blank?
    date_assigned.strftime('%m/%d/%Y')
  end

  def average
    divisor = score
    divisor = total_points if total_points > 0.0

    ((score / divisor) * 100.0).round(2)
  end

  def grade
    grade_letter(average)
  end
end
