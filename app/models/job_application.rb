class JobApplication < ApplicationRecord
  validates :cover_letter, presence: { message: 'deve ser preenchida.'}
  validates :feedback, presence: { message: 'deve ser preenchido.'}, on: [:update]
  belongs_to :job
  belongs_to :candidate
  has_one    :job_proposal
  enum status: {submitted: 0, approved: 5, declined: 9}
end
