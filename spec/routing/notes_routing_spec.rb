require "rails_helper"

RSpec.describe NotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/organizations/1/projects/1/reports/1/notes").to route_to("notes#index", :project_id => "1", :organization_id => "1", :report_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/organizations/1/projects/1/reports/1/notes/1").to route_to("notes#show", :project_id => "1", :organization_id => "1", :report_id => "1", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/organizations/1/projects/1/reports/1/notes").to route_to("notes#create", :project_id => "1", :organization_id => "1", :report_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/organizations/1/projects/1/reports/1/notes/1").to route_to("notes#update", :project_id => "1", :organization_id => "1", :report_id => "1", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/organizations/1/projects/1/reports/1/notes/1").to route_to("notes#update", :project_id => "1", :organization_id => "1", :report_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/organizations/1/projects/1/reports/1/notes/1").to route_to("notes#destroy", :project_id => "1", :organization_id => "1", :report_id => "1", :id => "1")
    end
  end
end
