class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.search(params[:term], params[:category])
    @number_of_projects = @projects.count
    @funded_projects = Project.funded.count
    @total_pledged = @projects.reduce(0) { |sum, project| sum + project.pledged_amount }
    @total_backers = @projects.reduce(0) { |sum, project| sum + project.backers.count }
    # @total_unique_backers
  end

  def show
    @project = Project.find(params[:id])
    if current_user
      @pledged_by_user = current_user.pledged_for(@project)
      check_if_backer
    end
    @total_pledged_for_project = @project.pledged_amount

    @backers = @project.backers

    @number_of_rewards = @project.rewards.count

    extract_posted_update
    @post_update = Comment.new
    @post_update.posted_update = true
    @comments = @project.comments.where(:posted_update => false).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @project = Project.new
    @project.rewards.build
    @categories = Category.all
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
      write_project_category
      redirect_to projects_url
    else
      render :new
    end
  end

  def check_if_backer
    unless @project.user_id == current_user.id
      if @project.backers.include?(current_user)
        flash.now[:notice] = "You have already backed that project."
      else
        flash.now[:notice] = "You have not backed that project yet."
      end
    end
  end

  def extract_posted_update
    if @project.end_date > Time.now.utc ||  @project.backers.include?(current_user) || @project.user_id == current_user.id
      @posted_updates = @project.comments.where(:posted_update => true).order(created_at: :desc)
    else
      @posted_updates = @project.comments.where(:posted_update => true).where("created_at < ?", @project.end_date).order(created_at: :desc)
    end
  end

  def write_project_category
    params[:project][:category_ids].each do |cat_id|
      unless cat_id == ""
        @project_category = Categories_Project.new
        @project_category.project_id = @project.id
        @project_category.category_id = cat.id

        @project_category.save
      end
    end
  end

end
