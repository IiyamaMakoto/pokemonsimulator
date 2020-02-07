class CreateTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :types do |t|
      t.string :name, null: false
      t.string :short

      t.timestamps
    end
  end
end
