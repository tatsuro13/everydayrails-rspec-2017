require 'rails_helper'

RSpec.describe HomeController, type: :controller do
    describe "#index" do
      it "responsds successfully" do
        get :index
        expect(response).to be_success
      end

      #200レスポンスを返すこと
      it "return a 200 response" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
end
