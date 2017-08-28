require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  subject(:user) do
    User.create!(username: "million_ants", password: "long_live_the_queen")
  end

  describe "GET #show" do
    it "renders the show view" do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    it "renders the index view" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's username and password" do
        post :create, params: {
          user: {
            username: "million_ants",
            password: ""
          }
        }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, params: {
          user: {
            username: "million_ants",
            password: "qu33n"
          }
        }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to user show on success" do
        post :create, params: {
          user: {
            username: "million_ants",
            password: "long_live_the_queen"
          }
        }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end
end
