class JobProposal < ApplicationRecord
  validates :start_date, :salary, :benefits, :job_roles, :job_expectations, presence: { message: 'deve ser preenchido.'}
  belongs_to :job_application
  belongs_to :headhunter
  enum status: {submitted: 0, accepted: 5, rejected: 9}
end
