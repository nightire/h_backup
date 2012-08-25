# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  useremail  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :useremail, :username

  before_save { |user| user.useremail = useremail.downcase }

  VALID_EMAIL_REGEX = /\A[\w]+[\-\.\+a-z0-9]+[a-z0-9]+@[a-z0-9]+[\-a-z0-9]+(\.[a-z]{2,4}){1,2}\z/i
  validates :username,  presence: true, length: { maximum: 30 }
  validates :useremail, presence: true, format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
end
