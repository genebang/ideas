class AddCategoryArchivedToIdea < ActiveRecord::Migration

  def up
    add_column :ideas, :category, :string, default: ""
    add_column :ideas, :archived_at, :timestamp
  end

  def down
    remove_column :ideas, :category
    remove_column :ideas, :archived_at
  end

end
