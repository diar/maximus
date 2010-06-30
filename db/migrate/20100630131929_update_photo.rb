class UpdatePhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :album_id, :integer
    remove_column :photos, :product_id
  end

  def self.down
    remove_column :photos, :album_id
    add_colum :photos, :product_id, :integer
  end
end
