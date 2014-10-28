# == Schema Information
#
# Table name: submissions
#
#  id            :integer          not null, primary key
#  comments      :string(255)
#  user_id       :integer
#  assignment_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Submission do
  pending "add some examples to (or delete) #{__FILE__}"
end
