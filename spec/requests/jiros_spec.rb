require 'rails_helper'

RSpec.describe "Jiros", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/jiros/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/jiros/show"
      expect(response).to have_http_status(:success)
    end
  end

end
