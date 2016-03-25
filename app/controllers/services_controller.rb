class ServicesController < ApplicationController
before_action :find_service, only: [:show,:update,:edit]

  def index
      @services = Service.all.order('dateworked desc')
  end

  def show

  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new service_params
    if @service.save
    redirect_to @service, notice: "Service has been Created!"
    else
      render "new", flash[:alert] => "Service not Created!"
    end
  end

  def edit

  end

  def update
    if @service.update service_params
      redirect_to @service, notice: "Service has been updated"
    else
      render "edit", flash[:alert] = "Service has not been updated"
    end
  end

  private

  def service_params
    params.require(:service).permit(:project_id, :user_id, :dateworked, :hours)
  end

  def find_service
    @service = Service.find params[:id]
  end
end
