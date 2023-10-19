class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false, limit: 50, unique: true
      t.string :icon, null: false

      t.timestamps
    end
  end
end
