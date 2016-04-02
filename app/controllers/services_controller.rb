class ServicesController < ApplicationController

  # before_action :authenticate_user!
  before_action :find_service, only: [:show,:update,:edit]

    def index
        @services = Service.all.order('dateworked desc')
        @service = Service.new
    end

    def show

    end

    def new
      @service = Service.new
    end

    def create
      @service = Service.new service_params
      #TODO verify the following line: i.e you're passing project id
      #@project = Project.find(params[:project_id])
      #@service.project = @project
      respond_to do |format|
        if @service.save
          Usermailer.servicecreated(@service).deliver_now
         format.html{redirect_to @service, notice: "Service has been Created!"}
         format.js {render}
        else
          format.html{render "new", flash[:alert] => "Service not Created!"}
          format.js {render}
        end
      end
    end
    def edit

    end

    def update
      respond_to do |format|
        if @service.update service_params
          format.html{redirect_to @service, notice: "Service has been updated"}
          format.js
        else
          format.html{render "edit", flash[:alert] = "Service has not been updated"}
          format.js
        end
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
