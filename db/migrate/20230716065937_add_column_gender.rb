class AddColumnGender < ActiveRecord::Migration[7.0]
  def self.up
    add_column :users, :gender, :string, :default => 'm'
  end
  def self.down
    remove_column :users, :gender
  end
end
