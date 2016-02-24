class GroupsController < ApplicationController
  before_filter :get_course
  before_filter :get_group, only: [:edit, :update, :destroy]

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
      @group.add_group_users(params[:students].split(','))
      flash[:success] = "Group created!"
      redirect_to course_groups_path(@course)
    else
      render "new"
    end
  end

  def edit
    authorize! :manage, @course
    @students = @course.student_course_users.includes(:user).map { |s| { course_user_id: s.id, name: s.user.name } }
    @group_users = @group.group_users.map { |s| s.course_user_id }
  end

  def update
    authorize! :manage, @course

    if @group.update_attributes(group_params)
      @group.modify_group_users(params[:students].split(','))
      flash[:success] = "Group updated!"
      redirect_to course_groups_path(@course)
    else
      render "edit"
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

  def get_group
    @group = Group.find(params[:group_id] || params[:id])
    unless @group.present?
      flash[:error] = "Invalid group!"
      redirect_to root_path
    end
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
