class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.boolean     :value
      t.integer     :user_id
      t.integer     :idea_id

      t.timestamps
    end
  end

  def down
    drop_table :votes
  end
end
