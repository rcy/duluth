class AddSortToItems < ActiveRecord::Migration
  def change
    add_column :items, :sort, :float, :default => 0.0

  end
end
