class AddColumnMoves < ActiveRecord::Migration[5.2]
  def change
    add_column :moves, :text, :string
  end
end
