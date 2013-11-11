require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET others pages" do

    it "should return 404 if the template does not exist." do
      expect {
        get "show", page: "this_page_doesnt_exist"
      }.to raise_error ActionController::RoutingError
    end

    # TODO: find a way to write test for when the template exists.
  end

end
