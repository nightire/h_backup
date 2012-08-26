require 'spec_helper'
include ApplicationHelper

describe 'Portal Pages' do
  subject { page }

  describe 'Home Page' do
    before { visit root_path }
    it { should have_selector 'title',    text: 'Happiness' }
    it { should have_selector 'a.logo',   text: 'Happiness' }
    it { should have_selector 'a.button', text: 'Sign up now!'}

    it "should have the right link to the signup page" do
      click_link "Sign up now!"
      page.should have_selector 'title',  text: full_title('Sign up')
      page.should have_selector 'h1',     text: 'Sign up'
    end
  end
end
