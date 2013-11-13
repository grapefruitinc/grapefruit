class CapsulesController < ApplicationController
	def new
  	@capsule = Capsule.new
  end

  def show
  	@capsule = Capsule.find(params[:id])
  end

  def create
  	@capsule = Capsule.new(params[:capsule])
  	if @capsule.save
  		flash[:success] = "Capsule created!"
  		redirect_to @capsule
  	else
  		render 'new'
  end

  def destroy
  	@capsule = @capsule.find(params[:id])
  	@capsule.destroy
  	redirect_to :back
  end
end
