class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :kind
      t.decimal :amount, null: false, precision: 16, scale: 2
      t.datetime :date
      t.references :user, null: false

      t.timestamps
    end
  end
end
