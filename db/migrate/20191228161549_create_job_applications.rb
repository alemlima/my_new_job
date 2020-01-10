class CreateJobApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :job_applications do |t|
      t.string :cover_letter
      t.references :job, foreign_key: true
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
