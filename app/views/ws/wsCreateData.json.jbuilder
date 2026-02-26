json.extract! @wsData, :personasobligacion_id, :error, :persona_id
json.persona_id @wsData.persona_id
json.personasobligacion_id @wsData.personasobligacion_id
json.error @wsData.error
