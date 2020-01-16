class AddHeadhunterRefToJobProposal < ActiveRecord::Migration[5.2]
  def change
    add_reference :job_proposals, :headhunter, foreign_key: true
  end
end
