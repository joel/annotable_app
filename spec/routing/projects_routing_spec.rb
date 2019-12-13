require "rails_helper"

RSpec.describe ProjectsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/organizations/1/projects").to route_to("projects#index", :organization_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/organizations/1/projects/1").to route_to("projects#show", :id => "1", :organization_id => "1")
    end


    it "routes to #create" do
      expect(:post => "/organizations/1/projects").to route_to("projects#create", :organization_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/organizations/1/projects/1").to route_to("projects#update", :id => "1", :organization_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/organizations/1/projects/1").to route_to("projects#update", :id => "1", :organization_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/organizations/1/projects/1").to route_to("projects#destroy", :id => "1", :organization_id => "1")
    end
  end
end
