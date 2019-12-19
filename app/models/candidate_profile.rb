class CandidateProfile < ApplicationRecord
  belongs_to :candidate
  enum status: {incomplete: 0, complete: 5}
end
