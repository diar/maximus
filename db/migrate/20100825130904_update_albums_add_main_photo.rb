class UpdateAlbumsAddMainPhoto < ActiveRecord::Migration
  def self.up
    add_column :albums, :main_photo_id, :integer
  end

  def self.down
    remove_column :albums, :main_photo_id
  end
end
