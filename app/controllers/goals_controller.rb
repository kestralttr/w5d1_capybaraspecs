class GoalsController < ApplicationController
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def new
    @goal = Goal.new
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def index
    @goals = Goal.where("privacy = 'public' OR user_id = #{current_user.id}")
    p @goals
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    render :index
  end

  private

  def goal_params
    params.require(:goal).permit(:body,:privacy,:completed)
  end
end
