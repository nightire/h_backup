require 'spec_helper'
include ApplicationHelper

describe "User Pages" do
  subject { page }

  describe "Sign up Page" do
    before { visit signup_path }
    it { should have_selector 'title',  text: full_title('Sign up') }
    it { should have_selector 'h1',     text: 'Sign up'}
  end

  describe "User's profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector 'title',  text: user.username }
    it { should have_selector 'h1',     text: user.username }
  end

  describe "Signup form page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Account Name", with: "Albert"
        fill_in "E-mail",       with: "albert@yucd.me"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
