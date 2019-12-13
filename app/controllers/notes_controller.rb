class NotesController < ApplicationController
  before_action :get_report
  before_action :set_note, only: [:show, :update, :destroy]

  # GET /notes
  def index
    @notes = @report.notes.all

    render json: @notes
  end

  # GET /notes/1
  def show
    render json: @note
  end

  # POST /notes
  def create
    @note = @report.notes.build(note_params)

    if @note.save
      render json: @note, status: :created, location: organization_project_report_note_url(@organization, @project, @report, @note)
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = @report.notes.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def note_params
      params.require(:note).permit(:title, :content, :report_id)
    end

    def get_report
      @organization = Organization.find(params.require(:organization_id))
      @project = @organization.projects.find(params.require(:project_id))
      @report  = @project.reports.find(params.require(:report_id))
    end
end
