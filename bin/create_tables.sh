#!/bin/bash

# How to run this script
#
# ./create_tables.sh > install.log 2>&1
#
# grep -i error install.log
#

# Variables

server=localhost
database=resume
porrt=5432
username=hena


# Create tables

/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/tables/accounts.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/tables/education.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/tables/skills.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/tables/experience.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/tables/experience_jobs.sql

