class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :name
      t.string :token
      t.string :name_downcased
      t.timestamps
    end
    add_index "bars", ["token"], name: "index_bars_on_token", unique: true
    add_index "bars", ["name_downcased"], name: "index_bars_on_name_downcased", unique: true
  end
end
