class Album < ActiveRecord::Base
  validates :band_id, :studio, presence: true
  validates :studio, inclusion: {in: ["studio", "live"] }
  belongs_to :band
  has_many :tracks, dependent: :destroy
end
