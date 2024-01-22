class CoursesController < ApplicationController
  before_action :set_course

  def show
  end

  private

  def course_params
    params.permit(:id)
  end

  def set_course
    @course = Course.find(course_params[:id])
  end
end
