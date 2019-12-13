require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /reports" do
    let(:report)       { FactoryBot.create :report }
    let(:project)      { report.project }
    let(:organization) { project.organization }

    it "works! (now write some real specs)" do
      get organization_project_reports_path(organization, project)
      expect(response).to have_http_status(200)
    end
  end
end
