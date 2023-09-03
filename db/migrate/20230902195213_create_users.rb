class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.decimal :balance, default: 0, precision: 16, scale: 2

      t.timestamps
    end
  end
end
