class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.integer :age
      t.integer :unique_identity
      t.text :address

      t.timestamps
    end
  end
end
