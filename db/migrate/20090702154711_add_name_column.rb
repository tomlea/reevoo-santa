class AddNameColumn < ActiveRecord::Migration
  def self.up
    add_column :recent_posts, :name, :string, :length => 30
  end

  def self.down
    remove_column :recent_posts, :name
  end
end
