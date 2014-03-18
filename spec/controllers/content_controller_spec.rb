require 'spec_helper'

describe ContentController do

  describe "GET 'basic'" do
    it "returns http success" do
      get 'basic'
      response.should be_success
    end
  end

  describe "GET 'pro'" do
    it "returns http success" do
      get 'pro'
      response.should be_success
    end
  end

end
