class ProblemSetsController < ApplicationController
	def new
  	@problemset = ProblemSet.new
  end

  def show
  	@problemset = ProblemSet.find(params[:id])
  end

  def create
  	@problemset = ProblemSet.new(params[:problemset])
  	if @problemset.save
  		flash[:success] = "Problem set created!"
  		redirect_to @problemset
  	else
  		render 'new'
  end

  def destroy
  	@problemset = @problemset.find(params[:id])
  	@problemset.destroy
  	redirect_to :back
  end
end
