class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :author_id
      t.string :name, null: false, limit: 100
      t.decimal :amount, null: false, greather_than_or_equal_to: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
