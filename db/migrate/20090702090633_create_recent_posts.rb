class CreateRecentPosts < ActiveRecord::Migration
  def self.up
    create_table :recent_posts do |t|
      t.column :source_ip, :string
      t.column :message, :string

      t.timestamps
    end
  end

  def self.down
    drop_table :recent_posts
  end
end
