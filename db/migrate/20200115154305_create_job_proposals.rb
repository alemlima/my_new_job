class CreateJobProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :job_proposals do |t|
      t.date :start_date
      t.integer :salary
      t.integer :status, default: 0
      t.string :benefits
      t.string :job_roles
      t.string :job_expectations
      t.string :additional_infos
      t.string :feedback

      t.timestamps
    end
  end
end
