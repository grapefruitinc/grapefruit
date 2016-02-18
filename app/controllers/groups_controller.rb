class GroupsController < ApplicationController
  before_filter :get_course

  layout "course"
  
  def index
    @groups = @course.groups
  end

  def new
    @group = @course.groups.new
    authorize! :manage, @course
    @students = @course.student_course_users.includes(:user).map { |s| { course_user_id: s.id, name: s.user.name } }
  end

  def create
    @group = @course.groups.new(group_params)
    authorize! :manage, @course

    if @group.save
      @group.add_course_users(params[:students].split(','))
      flash[:success] = "Group created!"
      redirect_to course_groups_path(@course)
    else
      render "new"
    end
  end

  # def create
  #   @student = User.find(params[:user_id])

  #   unless @course.students.include?(@student)
  #     @course.add_student(@student)

  #     redirect_to course_path(@course) if !@course.edited_by?(current_user)
  #   end
  # end

  # def destroy
  #   @student = User.find(params[:user_id] || params[:id])
  #   @course.remove_student(@student)
  #   if current_user == @student
  #     flash[:success] = "You left #{@course.name}."
  #     redirect_to courses_path and return
  #   end
  #   flash[:success] = "You removed #{@student.name} from the course."
  #   redirect_to course_people_path(@course)
  # end

private

  def group_params
    params.require(:group).permit(:name)
  end

end
