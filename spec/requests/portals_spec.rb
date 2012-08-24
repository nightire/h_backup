require 'spec_helper'
include ApplicationHelper

describe 'Portals' do
  subject { page }

  describe 'Home Page' do
    before { visit root_path }
    it { should have_selector 'title', text: 'Happiness' }
    it { should have_selector 'h1.logo', text: 'Happiness' }
  end
end
