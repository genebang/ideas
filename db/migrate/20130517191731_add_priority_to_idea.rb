class AddPriorityToIdea < ActiveRecord::Migration

  def up
    add_column :ideas, :priority, :string, default: -1
  end

  def down
    remove_column :ideas, :priority
  end

end
