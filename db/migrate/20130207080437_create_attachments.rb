class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.integer     :idea_id
      t.string      :image
      t.timestamps
    end
  end

  def down
    drop_table :attachments
  end
end
