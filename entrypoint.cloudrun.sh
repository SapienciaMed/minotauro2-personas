#!/bin/bash
set -e

echo "Iniciando aplicación en Cloud Run..."
echo "RAILS_ENV: $RAILS_ENV"

# En Cloud Run no corremos migraciones automáticas
# Las migraciones se corren manualmente o con un Job separado
# Si quieres correrlas igual, descomenta:
# bundle exec rake db:migrate

exec "$@"