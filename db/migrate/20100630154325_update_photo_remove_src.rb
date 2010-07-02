class UpdatePhotoRemoveSrc < ActiveRecord::Migration
  def self.up
    remove_column :photos, :src
    remove_column :photos, :src_min
  end

  def self.down
    add_column :photos, :src, :string
    add_column :photos, :src_min, :string
  end
end
