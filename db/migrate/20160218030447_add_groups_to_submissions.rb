class AddGroupsToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :group, index: true
  end
end
