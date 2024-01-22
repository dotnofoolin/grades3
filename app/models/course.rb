class Course < ApplicationRecord
  belongs_to :student
  has_many :assignments

  include GradeLetter

  def grade
    grade_letter(average)
  end

  def last_update_formatted
    return nil if last_update.blank?
    last_update.strftime('%m/%d/%Y')
  end

  def health_bar_color_class
    return 'is-success' if grade_letter(average) == 'A'
    return 'is-primary' if grade_letter(average) == 'B'
    return 'is-info' if grade_letter(average) == 'C'
    return 'is-warning' if grade_letter(average) == 'D'
    'is-danger'
  end
end
