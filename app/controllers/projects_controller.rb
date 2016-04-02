class ProjectsController < ApplicationController
  # before_action :authenticate_user!
  before_action :find_project, only: [:show,:update,:edit]
  def index
    @projects = Project.all
  end

  def show

  end

  def new
    @project = Project.new

  end

  def create
    @project = Project.new project_params
    @project.user = current_user
    # you need to associate the project with a user and since new doesn't have a
    # user associated in the database, we need to ensure the new project belongs to
    # current_user.
    @project.save
    redirect_to @project, notice: "Project has been Created!"
  end

  def edit

  end

  def update

    if @project.update project_params
      redirect_to @project, notice: "Project has been updated"
    else
      render "edit", flash[:alert] = "Work has not been updated"
    end
  end

  private
  def project_params
    params.require(:project).permit(:name,:company_id,:default_charge)
  end

  def find_project
    @project = Project.find params[:id]
  end


end
