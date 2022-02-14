require 'rails_helper'

RSpec.describe "Saunas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/saunas/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/saunas/show"
      expect(response).to have_http_status(:success)
    end
  end

end
