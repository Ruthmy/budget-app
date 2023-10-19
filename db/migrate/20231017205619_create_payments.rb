class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true, foreign_key_name: :author_id
      t.string :name, null: false, limit: 100
      t.float :amount, null: false, greather_than_or_equal_to: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
