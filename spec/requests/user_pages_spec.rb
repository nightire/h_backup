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
end
