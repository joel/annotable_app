class ProjectsController < ApplicationController
  before_action :get_organization
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = @organization.projects.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = @organization.projects.build(project_params)

    if @project.save
      render json: @project, status: :created, location: organization_project_url(id: @project, organization_id: @organization.to_param)
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = @organization.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :organization_id)
    end

    def get_organization
      @organization = Organization.find_by_legacy_id(params.require(:organization_id))
    end
end
