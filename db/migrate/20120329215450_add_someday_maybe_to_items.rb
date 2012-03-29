class AddSomedayMaybeToItems < ActiveRecord::Migration
  def change
    add_column :items, :maybe, :boolean, :default => false

  end
end
