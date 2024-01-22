module GradeLetter
  extend ActiveSupport::Concern

  def grade_letter(average)
    return 'A' if average >= 90.00
    return 'B' if (average >= 80.00 && average < 90.00)
    return 'C' if (average >= 70.00 && average < 80.00)
    return 'D' if (average >= 60.00 && average < 70.00)
    'F'
  end
end
