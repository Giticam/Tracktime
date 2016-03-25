class CompaniesController < ApplicationController
  before_action :find_company, only: [:show,:update,:edit]

  def index
    @companies = Company.all
  end

  def show
    respond_to do |format|
      format.html{}
      format.json{render json:@company}
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new company_params
    if @company.save
    redirect_to @company, notice: "Company Created!"
    else
    render 'new', flash[:alert] = "Company not Created!"
    end
  end

  def edit

  end

  def update
    if @company.update company_params
      redirect_to @company, notice: "Company has been updated"
    else
      render "edit", flash[:alert] = "Company has not been updated"
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
