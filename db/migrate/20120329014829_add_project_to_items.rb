class AddProjectToItems < ActiveRecord::Migration
  def change
    add_column :items, :project, :boolean, :default => false

  end
end
