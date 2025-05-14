#!/bin/bash
set -e

# Restore the database if it does not already exist.
if [ -f $GTS_DB_ADDRESS ]; then
  echo "Database exists, skipping restore."
else
  echo "No database found, attempt to restore from a replica."
  litestream restore -if-replica-exists $GTS_DB_ADDRESS
  echo "Finished restoring the database."
fi

echo "Starting litestream & gotosocial service."

# Run litestream with your app as the subprocess.
exec litestream replicate -exec \
  "/gotosocial/gotosocial server start"
