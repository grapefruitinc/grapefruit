class AssignmentTypesController < ApplicationController

  layout "course", only: [:index]

  before_filter :authenticate_user!, :get_course, :hide_sidebar

  def index
    @current_types = @course.assignment_types

    if request.xhr?
      render json: @current_types
    end
  end

  def create
    if request.xhr?
      name = params[:name]
      drops_lowest = params[:drops_lowest]
      default_point_value = params[:default_point_value]
      @assignment_type = @course.assignment_types.new(name: name, drops_lowest: drops_lowest, default_point_value: default_point_value)
      authorize! :manage, @course
      if @assignment_type.valid?
        @assignment_type.save
        render json: @assignment_type.id
      else
        render json: -1
      end
    end
  end

  def destroy
    authorize! :manage, @course
    @assignment_type = @course.assignment_types.find(params[:assignment_type_id] || params[:id])

    # don't delete existing assignments
    if @course.assignments.where(assignment_type: @assignment_type).count > 0
      render json: -1
    # don't delete the last assignment type in an assignment
    elsif @course.assignment_types.count == 1
      render json: -2
    else
      @assignment_type.destroy
      render json: 0
    end
  end

  def update
    authorize! :manage, @course
    @assignment_type = @course.assignment_types.find(params[:assignment_type_id] || params[:id])
    if @assignment_type.update_attributes(
      name: params[:name],
      drops_lowest: params[:drops_lowest],
      default_point_value: params[:default_point_value])
      render json: 0
    else
      render json: -1
    end
  end

  private

  def assignment_type_params(extra_params = {})
    params.require(:name).permit(:default_point_value, :drops_lowest, :percentage).merge(extra_params)
  end

end
