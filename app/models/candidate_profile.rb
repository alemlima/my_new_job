class CandidateProfile < ApplicationRecord
  belongs_to :candidate
  validates :name, presence: :true
  

  enum status: {incomplete: 0, complete: 5}

  def filled_up?
     [academic_background, description, professional_background, 
      photo, social_network, birth_date].all?{ |attr| attr.present?}
  end
end
