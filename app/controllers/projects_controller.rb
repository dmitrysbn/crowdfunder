class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
  end

  def show
    @project = Project.find(params[:id])
    pledges = current_user.pledges.where(:project => @project)
    @pledged = pledges.pluck(:dollar_amount).sum
    check_if_backed
    @backers = @project.backers
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]
    @project.user_id = current_user.id

    if @project.save
      redirect_to projects_url
    else
      render :new
    end
   end

end

def check_if_backed
  if @project.backers.include?(current_user)
    flash.now[:notice] = "You have already backed that project."
  else
    flash.now[:notice] = "You have not backed that project yet."
  end
end
