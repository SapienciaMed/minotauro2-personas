class CreateModuloscampos < ActiveRecord::Migration[5.0]
  def change
    create_table :moduloscampos do |t|
      t.references :modulo, foreign_key: true
      t.integer :orden
      t.string :encabezado
      t.string :campo, limit: 100
      t.string :tipo
      t.string :detalle

      t.timestamps
    end
  end
end
