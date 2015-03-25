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

require 'rails_helper'

RSpec.describe SchoolAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
