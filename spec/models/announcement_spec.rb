# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Announcement do
  pending "add some examples to (or delete) #{__FILE__}"
end
