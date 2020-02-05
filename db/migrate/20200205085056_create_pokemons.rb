class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name,       null: false
      t.string :no,         null: false
      t.integer :hp,        null: false
      t.integer :attack,    null: false
      t.integer :defence,   null: false
      t.integer :sp_atk,    null: false
      t.integer :sp_def,    null: false
      t.integer :speed,     null: false

      t.timestamps
    end
  end
end
