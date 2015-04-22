class UsersController < ApplicationController
  before_action :require_login, only: [:show]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user == @user
      @goals = @user.goals
    else
      @goals = @user.public_goals
    end
    render :show
  end

end
