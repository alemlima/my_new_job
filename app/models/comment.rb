class Comment < ApplicationRecord
  belongs_to :candidate_profile
  belongs_to :headhunter
  validates :body, presence: true
end
