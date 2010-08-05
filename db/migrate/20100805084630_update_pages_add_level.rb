class UpdatePagesAddLevel < ActiveRecord::Migration
  def self.up
    add_column :pages, :level, :integer,:default => 1
  end

  def self.down
    remove_column :pages, :level
  end
end