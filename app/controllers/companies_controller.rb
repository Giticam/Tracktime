class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_company, only: [:show,:update,:edit]

  def index
    @companies = Company.all
    @company = Company.new
  end

  def show
      # format.html{}
      # format.json{render json:@company}
  end

  def new
    @company = Company.new
  end

  def create
      @company = Company.new company_params
    respond_to do |format|
      if @company.save
      format.html {redirect_to @company, notice: "Company Created!"}
      format.json {render :show, status: :created, location: @company}
      format.js
      else
      format.html{render 'new', flash[:alert] = "Company not Created!"}
      format.json{render json: @company.errors, status: :unprocessable_entity}
      format.js
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @company.update company_params
        format.html {redirect_to @company, notice: "Company has been updated"}
        format.json {render :show, status: :ok, location: @company}
        format.js
      else
        format.html {render "edit", flash[:alert] = "Company has not been updated"}
        format.json {render json: @company.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end
    private

    def company_params
      params.require(:company).permit(:name)
    end

    def find_company
      @company = Company.find params[:id]
    end
end
