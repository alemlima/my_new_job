class AddFeedbackToJobApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :job_applications, :feedback, :string
  end
end
