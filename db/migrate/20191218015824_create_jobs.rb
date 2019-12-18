class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.string :desired_skills
      t.string :skill_level
      t.string :concract_type
      t.string :localization
      t.decimal :salary
      t.date :limit_date
      t.references :headhunter, foreign_key: true

      t.timestamps
    end
  end
end
