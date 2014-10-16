class ConvertVoteValueToInteger < ActiveRecord::Migration
  def up
    add_column :votes, :convert_value, :integer, default: 0
    Vote.all.each do |row|
      row.convert_value = row.value ? 1 : -1
      row.save
    end
    remove_column :votes, :value
    rename_column :votes, :convert_value, :value
  end

  def down
    add_column :votes, :convert_value, :boolean, default: nil
    Vote.all.each do |row|
      row.convert_value = row.value > 0 ? true : false
      row.save
    end
    remove_column :votes, :value
    rename_column :votes, :convert_value, :value
  end
end
