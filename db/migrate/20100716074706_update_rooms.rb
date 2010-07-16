class UpdateRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :coord_x, :integer,:default => 0
    add_column :rooms, :coord_y, :integer,:default => 0
  end

  def self.down
    remove_column :rooms, :coord_x
    remove_column :rooms, :coord_y
  end
end
