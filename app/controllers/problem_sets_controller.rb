class ProblemSetsController < ApplicationController
	def new
  	@pset = ProblemSet.new
  end

  def show
  	@pset = ProblemSet.find(params[:id])
  end

  def create
  	@pset = ProblemSet.new(params[:pset])
  	if @pset.save
  		flash[:success] = "Problem set created!"
  		redirect_to @pset
  	else
  		render 'new'
  end

  def destroy
  	@pset = @pset.find(params[:id])
  	@pset.destroy
  	redirect_to :back
  end
end
