class CreateCandidateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :candidate_profiles do |t|
      t.string :name
      t.string :social_name
      t.string :academic_background
      t.string :description
      t.string :professional_background
      t.string :photo
      t.string :social_network
      t.date :birth_date
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
