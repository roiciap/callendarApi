#!/bin/bash
su postgres -c "psql -U postgres -d postgres -f /app/create/prepare_db.sql"
su postgres -c "psql -U postgres -d postgres -f /app/create/account.sql"
su postgres -c "psql -U postgres -d postgres -f /app/create/events.sql"
