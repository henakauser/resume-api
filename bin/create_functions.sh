#!/bin/bash

# How to run this script
#
# ./create_functions.sh > install.log 2>&1
#
# grep -i error install.log
#

# Variables

server=localhost
database=resume
porrt=5432
username=hena


# Create functions

/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/accounts_create.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/accounts_read.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/education_create.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/education_read.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/skills_create.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/skills_read.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/experience_create.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/experience_read.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/experience_jobs_create.sql
/usr/bin/psql -h $server -U $username -d $database -p $port -w < ./postgres/functions/experience_jobs_read.sql

