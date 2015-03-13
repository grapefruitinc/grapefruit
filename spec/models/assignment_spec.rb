# == Schema Information
#
# Table name: assignments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text(65535)
#  points             :float(24)
#  course_id          :integer
#  assignment_type_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#  reveal_day         :date
#  due_day            :date
#

require 'spec_helper'

describe Assignment do
  pending "add some examples to (or delete) #{__FILE__}"
end
