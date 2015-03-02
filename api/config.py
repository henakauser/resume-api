"""Default configuration settings"""

DEBUG = True
TESTING = False

# Logging

LOGGER_NAME = 'api-server'
LOG_FILENAME = 'api-server.log'

# PostgreSQL

USE_POSTGRESQL = True
POSTGRESQL_DATABASE = 'my_resume'
POSTGRESQL_USER = 'learn'
POSTGRESQL_PASSWORD = 'pass.word'
POSTGRESQL_HOST = 'localhost'
POSTGRESQL_PORT = '5432'
