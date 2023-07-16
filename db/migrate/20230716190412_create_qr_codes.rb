class CreateQrCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :qr_codes do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
