class UpdatePagesAddShowOnMenu < ActiveRecord::Migration
  def self.up
     add_column :pages, :show_menu, :boolean
  end

  def self.down
    remove_column :pages, :show_menu
  end
end
