#!/bin/bash
set -e

# Eliminar archivos previos de servidor
rm -f /home/sapiencia/app/tmp/pids/server.pid

echo "Iniciando aplicación..."
echo "RAILS_ENV: ${RAILS_ENV:-development}"

# ─────────────────────────────────────────────────────────────────
# Solo en desarrollo: esperar Oracle y correr migraciones
# En producción (Cloud Run) esto se omite
# ─────────────────────────────────────────────────────────────────
if [ "${RAILS_ENV}" = "development" ]; then
  echo "Esperando a que Oracle Database esté listo..."
  until echo "SELECT 1 FROM dual;" | sqlplus -L $DB_USER/$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_SERVICE 2>/dev/null; do
    echo "Oracle no disponible aún, reintentando en 2s..."
    sleep 2
  done
  echo "Oracle listo. Ejecutando migraciones..."
  bundle exec rake db:migrate || bundle exec rake db:setup
fi

# Iniciar el servidor Rails
exec "$@"