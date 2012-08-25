# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  useremail       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(username: 'nightire', useremail: 'nightire@gmail.com',
                     password: 'password', password_confirmation: 'password')
  end

  subject { @user }
  it { should respond_to :username, :useremail, :password_digest,
                         :password, :password_confirmation, :authenticate}
  it { should be_valid }

  describe "when username is not present" do
    before { @user.username = ' ' }   # intended to put a space
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = 'a' * 31 }
    it { should_not be_valid }
  end

  describe "when useremail is not present" do
    before { @user.useremail = ' ' }   # intended to put a space
    it { should_not be_valid }
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[ nightire@gmail.com
                      NightIRE@gMAil.Com.cn
                      123456789@num-000.mobi
                      ni_gh-t.ir+e@rubymine.oRg.tv ]

      addresses.each do |valid_address|
        @user.useremail = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[ @gmail.com
                      nightire@
                      -nightire@gmail_fake.com
                      _nightire@-gmail.com
                      +nightire@+gmail.com
                      nightire-@gmail-.com
                      nightire_@gmail_.com
                      nightire+@gmail+.com
                      nigh tire@gm ail.com
                      nightire@gma il.com
                      nightire#gmail.com
                      nightire@gmail.123
                      nightire@gmail.toomuch ]

      addresses.each do |invalid_address|
        @user.useremail = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email address is already be taken" do
    before do
      # because we made the useremail case insenstively, the user might be
      # use different case but same address to duplicate the account, so we
      # need to take care of this circumstance before we actually save it.
      user_with_same_email = @user.dup
      user_with_same_email.useremail = @user.useremail.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = ' ' }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_useremail(@user.useremail) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate('invalid') }

      it { should_not == user_with_invalid_password }
      specify { user_with_invalid_password.should be_false }
    end
  end
end
