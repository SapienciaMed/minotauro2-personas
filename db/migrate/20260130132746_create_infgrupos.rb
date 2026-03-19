class CreateInfgrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :infgrupos do |t|
      t.string :nombre, limit: 100
      t.string :nombre_archivo, limit: 50
      t.string :estado, limit: 50
      t.string :clase, limit: 100
      t.string :consulta, limit: 4000

      t.timestamps
    end
  end
end
