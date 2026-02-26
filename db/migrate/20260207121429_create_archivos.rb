class CreateArchivos < ActiveRecord::Migration[5.0]
  def change
    create_table :archivos do |t|
      t.references :user, foreign_key: true
      t.string :proceso
      t.string :estado, limit: 100
      t.attachment :upload
      t.string :mensaje, limit: 2000

      t.timestamps
    end
  end
end
