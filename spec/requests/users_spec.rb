require 'spec_helper'
include ApplicationHelper

describe "Users" do
  subject { page }

  describe "Sign up Page" do
    before { visit signup_path }
    it { should have_selector 'title',  text: full_title('Sign up') }
    it { should have_selector 'h1',     text: 'Sign up'}
  end
end
