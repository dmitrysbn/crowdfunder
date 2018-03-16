class PledgesController < ApplicationController
  before_action :require_login

  def create
    @project = Project.find(params[:project_id])

    @pledge = @project.pledges.build
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.reward_id = params[:pledge][:reward_id]
    @pledge.user = current_user

    if @pledge.reward_id
      @reward = Reward.find(params[:pledge][:reward_id])
    end
    
    if @reward
      @reward.times_claimed += 1
      @reward.save
    end

    if @pledge.save
      redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}!"
    else
      flash[:alert] = @pledge.errors.full_messages.first
      redirect_to project_url(@project)
    end
  end

end
