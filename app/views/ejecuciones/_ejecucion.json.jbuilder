json.extract! ejecucion, :id, :user_id, :procedimiento, :descripcion, :inicioejecucion, :finejecucion, :estado, :observacion, :tiempoejecucion, :procesamiento_id, :created_at, :updated_at
json.url ejecucion_url(ejecucion, format: :json)
