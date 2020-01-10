class JobApplication < ApplicationRecord
  validates :cover_letter, presence: { message: ' deve ser preenchida.'}
  belongs_to :job
  belongs_to :candidate
end
