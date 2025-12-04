class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build(plan_params)
    @plan.users << current_user
    if @plan.save
      redirect_to calendar_path, notice: "予定を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      redirect_to @plan, notice: "予定を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @plan.destroy
    redirect_to calendar_path, notice: "予定を削除しました"
  end

  def today
    @plans = current_user.plans.where(start_time: Date.today.all_day).order(:start_time)
    if @plans.present?
      render :today
    else
      redirect_to plans_path, notice: "今日の予定はありません"
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:title, :start_time, :end_time, :note, user_ids: [])
  end

end
