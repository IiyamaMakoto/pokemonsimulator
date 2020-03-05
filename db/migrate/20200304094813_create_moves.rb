class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.references :type, null: false, foreign_key: true
      t.integer :power
      t.integer :max_power
      t.integer :accuracy
      t.integer :pp
      t.integer :critical, default: 0
      t.boolean :contact, default: false
      t.integer :multi_hit
      t.integer :priority, default: 0

      t.timestamps
    end
  end
end
