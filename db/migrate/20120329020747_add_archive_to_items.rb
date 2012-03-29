class AddArchiveToItems < ActiveRecord::Migration
  def change
    add_column :items, :archive, :boolean, :default => false

  end
end
