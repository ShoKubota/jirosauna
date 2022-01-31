# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Maps', type: :request do
  describe 'GET /search' do
    it 'returns http success' do
      get '/maps/'
      expect(response).to have_http_status(:success)
    end
  end
end
