# == Schema Information
#
# Table name: group_users
#
#  id             :integer          not null, primary key
#  group_id       :integer
#  course_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
