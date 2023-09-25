#!/bin/bash
postgresql="$(/bin/bash -c "find / -type f -iname postgresql.conf 2>/dev/null")"
pg_hba="$(/bin/bash -c "find / -type f -name pg_hba.conf 2>/dev/null")"

# Make changes here if you want to deny access from any devices or IPs
echo -e "\nlisten_addresses = '*'" >> $postgresql

# And here
echo -e "\nhost    all    all    localhost        trust" >> $pg_hba
exit
