class HacImporter
  class OtherError < StandardError; end
  class NilResultsError < StandardError; end

  LOGFILE = "#{Rails.root}/log/hac_importer.log"

  attr_reader :data

  def initialize(credentials = nil)
    @data = nil
    @credentials = credentials
  end

  def import
    all_hac_credentials.each do |hac_credentials|
      log "#{Time.now} ---- Starting HAC import for #{hac_credentials[:school]} ----"
      get_data(hac_credentials)
      raise NilResultsError, 'Data from HAC is nil!' if data.blank?

      data.each do |s|
        student = Student.find_or_create_by(student_id: s[:student_id], name: s[:student_name])

        s[:classes].each do |c|
          course = Course.find_or_create_by(student: student, name: c[:class_name])
          course.update(
            average: convert_average(c[:average]),
            last_update: convert_date(c[:last_update])
          )

          c[:assignments].each do |a|
            assignment = Assignment.find_or_create_by(course: course, student: student, name: a[:assignment_name])
            assignment.update(
              date_assigned: convert_date(a[:date_assigned]),
              due_date: convert_date(a[:due_date]),
              category: a[:category],
              score: a[:score].to_f,
              total_points: a[:total_points].to_f
            )
          end
        end
      end

      log "#{Time.now} ---- Finished HAC import for #{hac_credentials[:school]} ----"
    end

    self
  end

  private

  def logger
    @logger ||= Logger.new(LOGFILE)
  end

  def log(string = '')
    logger.info(string)
  end

  def all_hac_credentials
    # Should be an array of objects with keys: :url, :school, :username, :password
    return [@credentials] if @credentials.present?
    Rails.application.credentials.hac_credentials
  end

  def get_data(credentials)
    begin
      @data = HacAdapter.all_reports(credentials)
    rescue => e
      log e.message
      raise OtherError, e.message
    end
  end

  def convert_date(date)
    return nil if date.blank?
    Date.strptime(date, '%m/%d/%Y')
  end

  def convert_average(average)
    # Handle "Current Grade B" average from certain schools. Convert letter to number for now.
    if average =~ /Current Grade/
      letter = average.last
      return 99.0 if letter.upcase == 'A'
      return 89.0 if letter.upcase == 'B'
      return 79.0 if letter.upcase == 'C'
      return 69.0 if letter.upcase == 'D'
      return 59.0 if letter.upcase == 'F'
    end

    average.to_f
  end
end
