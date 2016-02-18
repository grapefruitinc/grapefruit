# == Schema Information
#
# Table name: submissions
#
#  id            :integer          not null, primary key
#  comments      :text(65535)
#  user_id       :integer
#  assignment_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  group_id      :integer
#

require 'spec_helper'

describe Submission do
  pending "add some examples to (or delete) #{__FILE__}"
end
