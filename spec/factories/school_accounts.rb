# == Schema Information
#
# Table name: school_accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  url        :string(255)
#  short_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :school_account do
    name "MyString"
url "MyString"
short_name "MyString"
  end

end
