class UpdatePagesAddShowAdditional < ActiveRecord::Migration
  def self.up
    add_column :pages, :show_additional, :boolean, :default=>1
  end

  def self.down
    remove_column :pages, :show_additional
  end
end
