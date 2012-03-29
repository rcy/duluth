class AddAttributesToItems < ActiveRecord::Migration
  def change
    add_column :items, :action, :boolean, :default => false

    add_column :items, :waiting, :boolean, :default => false

  end
end
