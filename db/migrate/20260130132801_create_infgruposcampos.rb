class CreateInfgruposcampos < ActiveRecord::Migration[5.0]
  def change
    create_table :infgruposcampos do |t|
      t.references :infgrupo, foreign_key: true
      t.integer :orden
      t.string :nombre, limit: 500
      t.string :campo, limit: 50
      t.string :estilo, limit: 50
      t.string :tipo, limit: 50
      t.string :tamano, limit: 20
      t.string :estilo_encabezado, limit: 50

      t.timestamps
    end
  end
end
