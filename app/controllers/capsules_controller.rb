class CapsulesController < ApplicationController
  
  before_filter :get_course
  before_filter :get_capsule, only: [:show, :edit, :update, :destroy]
  before_filter :get_other_capsules, only: [:new, :show]
  before_filter :authenticate_user!

  layout "course"

  def new
    @capsule = @course.capsules.new
    @capsule.name = "New Capsule"
    authorize! :create, @capsule
  end

  def create
    @capsule = @course.capsules.new(capsule_params)
    authorize! :create, @capsule
    if @capsule.save
      flash[:success] = "Capsule created!"
      redirect_to [@course, @capsule]
    else
      render 'new'
    end
  end
  
  def show
    @lectures = @capsule.lectures.order("created_at ASC")
    @problem_sets = @capsule.problem_sets.order("created_at ASC")
    @documents = @capsule.documents
    @lectures.build
    @problem_sets.build
  end

  def edit
    authorize! :update, @capsule
  end

  def update
    authorize! :update, @capsule
    if @capsule.update_attributes(capsule_params)
      flash[:success] = "Capsule updated!"
      redirect_to [@course, @capsule]
    else
      render "edit"
    end
  end

  def destroy
    authorize! :delete, @capsule
    @capsule.destroy
    redirect_to :back
  end

private

  def capsule_params
    params.require(:capsule).permit(:name)
  end

  def get_other_capsules
    @capsules = @course.capsules
  end
  
end