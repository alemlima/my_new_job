class JobApplication < ApplicationRecord
  validates :cover_letter, presence: :true
  validates :feedback, presence: :true, on: [:update]
  belongs_to :job
  belongs_to :candidate
  has_one    :job_proposal
  enum status: {submitted: 0, approved: 5, declined: 9}
end
