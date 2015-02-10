# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  lecture_id :integer
#  author_id  :integer
#  body       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
