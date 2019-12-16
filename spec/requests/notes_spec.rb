require 'rails_helper'

RSpec.describe "Notes", type: :request do
  describe "GET /notes" do
    let(:note)         { FactoryBot.create :note }
    let(:report)       { note.report }
    let(:project)      { report.project }
    let(:organization) { project.organization }

    it "works! (now write some real specs)" do
      get organization_project_report_notes_path(organization.to_param, project, report.to_param)
      expect(response).to have_http_status(200)
    end
  end
end
