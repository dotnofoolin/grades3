require "test_helper"

class HacImporterTest < ActiveSupport::TestCase
  setup do
    Assignment.delete_all
    Course.delete_all
    Student.delete_all
  end

  test '#import gathers data from HAC and saves it to database' do
    credentials = {
      url: "http://hac23.esp.k12.ar.us/HomeAccess",
      school: "Little Rock School District",
      username: "random",
      password: "random"
    }

    hac_importer = HacImporter.new(credentials)

    VCR.use_cassette("hac_all_reports", record: :once) do
      assert_nothing_raised { hac_importer.import }
    end

    assert_operator Student.all.count, :>, 0
    assert_operator Course.all.count, :>, 0
    assert_operator Assignment.all.count, :>, 0

    assignment = Assignment.last
    assert assignment.valid?
    assert assignment.course.valid?
    assert assignment.course.student.valid?
  end

  test '#import converts weird average strings into a numeric value' do
    credentials = {
      url: "http://hac23.esp.k12.ar.us/HomeAccess",
      school: "Pulaski County Special SD",
      username: "random",
      password: "random"
    }

    hac_importer = HacImporter.new(credentials)

    VCR.use_cassette("hac_all_reports_weird_average", record: :once) do
      assert_nothing_raised { hac_importer.import }
    end

    assert_operator Student.all.count, :>, 0
    assert_operator Course.all.count, :>, 0
    assert_operator Assignment.all.count, :>, 0
    assert_operator Course.where('average > 70.0').count, :>, 0
  end
end
