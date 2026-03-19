class CreateMigracioneslinks < ActiveRecord::Migration[5.0]
  def change
    create_table :migracioneslinks do |t|
      t.integer :consecutivo
      t.references :user, foreign_key: true
      t.integer :archivo_id
      t.string :identificacion, limit: 30
      t.string :nro_obligacion, limit: 30
      t.integer :valor
      t.string :mensaje, limit: 500
      t.integer :persona_id
      t.integer :personasobligacion_id
      t.string :estado, limit: 30
      t.string :error, limit: 1000

      t.timestamps
    end
  end
end
