#!/bin/bash
set -e

# Eliminar archivos previos de servidor
rm -f /home/sapiencia5/app/tmp/pids/server.pid

# Esperar a que MySQL externo esté disponible
echo "Esperando a que Oracle Database esté listo..."
until echo "SELECT 1 FROM dual;" | sqlplus -L $DB_USER/$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_SERVICE; do
  sleep 2
done

echo "MySQL está listo. Ejecutando migraciones..."
bundle exec rake db:migrate || bundle exec rake db:setup

# Iniciar el servidor Rails
exec bundle exec rails server -b 0.0.0.0 -p 3000
