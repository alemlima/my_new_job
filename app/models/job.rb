class Job < ApplicationRecord
  belongs_to :headhunter
  has_many :job_application
  has_many :candidate, through: :job_application 
end
