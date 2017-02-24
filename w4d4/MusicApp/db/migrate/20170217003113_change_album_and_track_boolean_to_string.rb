class ChangeAlbumAndTrackBooleanToString < ActiveRecord::Migration
  def change
    change_column :albums, :studio, :string
    change_column_default :albums, :studio, 'studio'

    change_column :tracks, :bonus, :string
    change_column_default :tracks, :bonus, 'regular'
  end
end
