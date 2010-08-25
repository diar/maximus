class UpdatePagesAddShowVacantion < ActiveRecord::Migration
  def self.up
    add_column :pages, :show_vacancy, :boolean, :default=>1
  end

  def self.down
    remove_column :pages, :show_vacancy
  end
end
