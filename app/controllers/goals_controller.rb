class GoalsController < ApplicationController
  before_action :require_login
  before_action :require_ownership, only: [:edit, :update]

  def index
    @goals = current_user.visible_goals
    render :index
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def new
    @goal = Goal.new
    render :new
  end

  def edit
    @goal = Goal.find(params[:id])
    render :new
  end

  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash[:errors] << @goal.errors.full_messages
      render :new
    end
  end



  private
    def goal_params
      params.require(:goal).permit(:title, :content, :private, :complete)
    end

    def require_ownership
      Goal.find(params[:id]).user == current_user
    end
end
