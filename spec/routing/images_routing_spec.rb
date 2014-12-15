require "spec_helper"

describe ImagesController do
  describe "routing" do

    before :each do
      Permission.any_instance.stub(:allow?).and_return true
      UrlValidator.any_instance.stub(:validate_each).and_return true
    end


    it "routes to #index" do
      get("/images").should route_to("images#index")
    end

    it "routes to #show" do
      get("/images/1").should route_to("images#show", :id => "1")
    end

    it "routes to #edit" do
      get("/images/1/edit").should route_to("images#edit", :id => "1")
    end

    it "routes to #update" do
      put("/images/1").should route_to("images#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/images/1").should route_to("images#destroy", :id => "1")
    end

  end
end
