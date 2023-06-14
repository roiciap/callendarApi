#!/bin/bash
su postgres -c "psql -U postgres -d postgres -f /app/create/account.sql"
