class CompaniesController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :edit, :update, :delete]
  before_action :find_company, only: [:show,:update,:edit,:destroy]

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
      format.html{redirect_to @company, notice: "Company Created!"}
      format.json{render :show, status: :created, location: @company}
      format.js
      else
      format.html{render 'new', flash[:alert] => "Company not Created!"}
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
        format.html{redirect_to @company, notice: "Company has been updated"}
        format.json{render :show, status: :ok, location: @company}
        format.js
      else
        format.html{render "edit",flash[:alert]=>"Company has not been updated"}
        format.json{render json: @company.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  def destroy
      @company.destroy
      redirect_to companies_path, notice:"Company Deleted.!!"
  end
    private

    def company_params
      params.require(:company).permit(:name)
    end

    def find_company
      @company = Company.find params[:id]
    end

    def admin_user
      redirect_to companies_path, :alert => "Only Admins authorized to create/modify a company" unless current_user.admin
    end
end
