UPDATE pg_catalog.pg_database SET datallowconn=false WHERE datname='resume';
DROP DATABASE IF EXISTS resume;
