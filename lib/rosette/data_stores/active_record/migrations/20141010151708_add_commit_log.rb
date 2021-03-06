# encoding: UTF-8

class AddCommitLog < ActiveRecord::Migration
  def up
    create_table :commit_logs do |t|
      t.string :repo_name, limit: 255, null: false
      t.string :commit_id, limit: 45, null: false
      t.integer :phrase_count, default: 0
      t.string :status, limit: 255
      t.timestamps
    end

    add_index :commit_logs, [:commit_id], unique: true
  end

  def down
    drop_table :commit_logs
  end
end
