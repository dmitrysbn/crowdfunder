class CommentsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :load_comment, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new

    @comment.comment = params[:comment][:comment]
    @comment.project_id = params[:project_id]
    @comment.posted_update = params[:comment][:posted_update]
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to "/projects/#{params[:project_id]}"
    else
      flash[:alert] = "Comment cannot be empty!"
      redirect_to "/projects/#{params[:project_id]}"
    end
  end

  def edit
    @project = @comment.project
  end

  def update
    @comment.comment = params[:comment][:comment]

    if @comment.save
      redirect_to "/projects/#{params[:project_id]}"
    else
      flash[:alert] = "Comment cannot be empty!"
      redirect_to "/projects/#{params[:project_id]}/comments/#{params[:id]}/edit"
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "You have successfully deleted the comment!"
    redirect_to "/projects/#{params[:project_id]}"
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def ensure_user_owns_comment
    unless current_user == @comment.user
      flash[:alert] = "Please log in"
      redirect_to login_path
    end
  end

end
