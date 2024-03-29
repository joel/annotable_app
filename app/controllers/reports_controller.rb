class ReportsController < ApplicationController
  before_action :get_project
  before_action :set_report, only: [:show, :update, :destroy]

  # GET /reports
  def index
    @reports = @project.reports.all

    render json: @reports
  end

  # GET /reports/1
  def show
    render json: @report
  end

  # POST /reports
  def create
    @report = @project.reports.build(report_params.merge({ organization_id: @organization.id }))

    if @report.save
      @report.reload
      render json: @report, status: :created, location: organization_project_report_url(@organization.to_param, @project, @report.to_param)
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = @project.reports.find_by_legacy_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def report_params
      params.require(:report).permit(:name, :content)
    end

    def get_project
      @organization = Organization.find_by_legacy_id(params.require(:organization_id))
      @project = @organization.projects.find(params.require(:project_id))
    end
end
