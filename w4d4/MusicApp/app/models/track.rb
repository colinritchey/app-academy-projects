class Track < ActiveRecord::Base
  validates :album_id, :bonus, presence: true

  belongs_to :album
end
