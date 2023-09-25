#!/bin/bash
dump_file="$(/bin/bash -c "find / -iname *.pgdump 2>/dev/null")"
dbname=derpibooru

echo "Restoring DB using $dump_file"

dropdb -U postgres --if-exists $dbname
createdb -U postgres $dbname

pg_restore -U postgres -O --verbose -d $dbname "$dump_file" || exit 1

echo -e "\n\nRestoring base $dbname from file $dump_file was successful!\n\n"