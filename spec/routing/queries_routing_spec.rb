require "spec_helper"

describe QueriesController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/queries").to route_to("queries#index")
    end

    it "routes to #new" do
      expect(:get => "/queries/new").to route_to("queries#new")
    end

    it "routes to #show" do
      expect(:get => "/queries/1").to route_to("queries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/queries/1/edit").to route_to("queries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/queries").to route_to("queries#create")
    end

    it "routes to #update" do
      expect(:put => "/queries/1").to route_to("queries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/queries/1").to route_to("queries#destroy", :id => "1")
    end

  end
end
