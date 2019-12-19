class AddStatusToCandidateProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :candidate_profiles, :status, :integer, default: 0
  end
end
