class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_project, only: [:show,:update,:edit]
  def index
    @projects = Project.all
    @project = Project.new
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
    respond_to do |format|
      if @project.save
        format.html{redirect_to @project, notice: "Project has been Created!"}
        format.js{render}
      else
        format.html{render "new", flash[:alert] => "Project not Created!"}
        format.js {render}
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @project.update project_params
        Usermailer.projectcreated(@project).deliver_now
        format.html{redirect_to @project, notice: "Project has been updated"}
        format.js{render}
      else
        format.html{render "edit", flash[:alert] => "Work has not been updated"}
        format.js{render}
      end
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
