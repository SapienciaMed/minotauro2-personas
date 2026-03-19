#!/bin/bash
set -e

# Eliminar archivos previos de servidor
rm -f /home/sapiencia/app/tmp/pids/server.pid

echo "Iniciando aplicación..."
echo "RAILS_ENV: ${RAILS_ENV:-development}"

# Iniciar el servidor Rails
exec "$@"