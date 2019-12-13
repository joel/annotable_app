require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:organization) { FactoryBot.create(:organization) }
  describe "GET /projects" do
    it "works! (now write some real specs)" do
      get organization_projects_path(organization)
      expect(response).to have_http_status(200)
    end
  end
end
