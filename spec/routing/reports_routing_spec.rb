require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/organizations/1/projects/1/reports").to route_to("reports#index", :project_id => "1", :organization_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/organizations/1/projects/1/reports/1").to route_to("reports#show", :id => "1", :project_id => "1", :organization_id => "1")
    end


    it "routes to #create" do
      expect(:post => "/organizations/1/projects/1/reports").to route_to("reports#create", :project_id => "1", :organization_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/organizations/1/projects/1/reports/1").to route_to("reports#update", :id => "1", :project_id => "1", :organization_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/organizations/1/projects/1/reports/1").to route_to("reports#update", :id => "1", :project_id => "1", :organization_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/organizations/1/projects/1/reports/1").to route_to("reports#destroy", :id => "1", :project_id => "1", :organization_id => "1")
    end
  end
end
