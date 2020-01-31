class CandidateProfile < ApplicationRecord
  belongs_to :candidate
  validates :name, presence: :true
  has_one_attached :photo  
  enum status: {incomplete: 0, complete: 5}
  
  after_validation :filled_up?, on:[:create, :update]
  

    def filled_up?
      self.status = 5 if [academic_background, description, professional_background, 
                          photo, social_network, birth_date].all?{ |attr| attr.present?}
    end
end
