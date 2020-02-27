class Job < ApplicationRecord
  belongs_to :headhunter
  has_many :job_application
  has_many :candidate, through: :job_application
  enum status: {open: 0, halted: 5, closed: 9}
end
