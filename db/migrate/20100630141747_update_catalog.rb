class UpdateCatalog < ActiveRecord::Migration
  def self.up
    add_column :albums, :visible, :boolean
    add_column :photos, :in_voting, :boolean
  end

  def self.down
    remove_column :albums, :visible
    remove_column :photos, :in_voting
  end
end
