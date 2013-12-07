# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  file        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Document < ActiveRecord::Base
  mount_uploader :file, DocumentUploader
end
