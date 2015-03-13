# == Schema Information
#
# Table name: grades
#
#  id            :integer          not null, primary key
#  points        :float(24)
#  comments      :text(65535)
#  assignment_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Grade do
  pending "add some examples to (or delete) #{__FILE__}"
end
