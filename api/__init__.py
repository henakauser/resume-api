from contextlib import contextmanager
import logging
from logging.handlers import RotatingFileHandler
from flask import Flask, request, jsonify
from psycopg2 import OperationalError
from psycopg2.pool import ThreadedConnectionPool
import sys

app = Flask(__name__)


# Configuration

app.config.from_object('api.config')
# app.config.from_envvar('API_CONFIG')


# Logging
# Disable logging during testing
# Enable console during development
# ref: https://gist.github.com/ibeex/3257877

log = logging.getLogger('werkzeug')

if not app.config['TESTING']:
    formatter = logging.Formatter(
        "[%(asctime)s] {%(pathname)s:%(lineno)d} %(levelname)s - %(message)s")
    handler = RotatingFileHandler(app.config['LOG_FILENAME'],
                                  maxBytes=10000000,
                                  backupCount=5)
    handler.setLevel(logging.DEBUG)
    handler.setFormatter(formatter)
    app.logger.addHandler(handler)

    # Output the werkzeug access logs to the same file
    log.setLevel(logging.DEBUG)
    log.addHandler(handler)

if app.config['DEBUG'] and not app.config['TESTING']:
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_format = logging.Formatter('%(message)s')
    console_handler.setFormatter(console_format)
    log.addHandler(console_handler)


# Database

if app.config['USE_POSTGRESQL']:
    try:
        pool = ThreadedConnectionPool(
            1,
            20,
            database=app.config['POSTGRESQL_DATABASE'],
            user=app.config['POSTGRESQL_USER'],
            password=app.config['POSTGRESQL_PASSWORD'],
            host=app.config['POSTGRESQL_HOST'],
            port=app.config['POSTGRESQL_PORT']
        )
    except OperationalError as oe:
        app.logger.error(oe)
        app.logger.error('Unable to connect to PostgreSQL.')
        sys.exit()
    else:
        app.logger.info('Connected to PostgreSQL.')


@contextmanager
def get_db_connection():
    """
    psycopg2 connection context manager.
    Fetch a connection from the connection pool and release it.
    """
    try:
        connection = pool.getconn()
        yield connection
    finally:
        pool.putconn(connection)


@contextmanager
def get_db_cursor(commit=False):
    """
    psycopg2 connection.cursor context manager.
    Creates a new cursor and closes it, commit changes if specified.
    """
    with get_db_connection() as connection:
        # cursor = connection.cursor(
        #    cursor_factory=psycopg2.extras.RealDictCursor)
        cursor = connection.cursor()
        try:
            yield cursor
            if commit:
                connection.commit()
        finally:
            cursor.close()


# Error responses


def extract_message(err):
    """
    Extract the custom error message if it exists or return an empty
    string. abort() accepts a dict that it then attaches to the error object's
    description.
    """
    try:
        message = err.description['message']
    except TypeError:
        message = ''
    return message


def extract_validation(err):
    """Extract all validation messages if any exist or return an empty dict."""
    try:
        validation = err.description['validation']
    except TypeError:
        validation = {}
    return validation


@app.errorhandler(400)
def bad_request(err=None):
    return jsonify({
        'status': 400,
        'type': 'Bad request',
        'url': request.url,
        'message': extract_message(err),
        'validation': extract_validation(err)
    }), 400


@app.errorhandler(403)
def forbidden(err=None):
    return jsonify({
        'status': 403,
        'type': 'Access denied',
        'url': request.url,
        'message': extract_message(err)
    }), 403


@app.errorhandler(404)
def not_found(err=None):
    return jsonify({
        'status': 404,
        'type': 'Resource not found',
        'url': request.url,
        'message': extract_message(err)
    }), 404


@app.errorhandler(500)
def internal_server_error(err=None):
    return jsonify({
        'status': 500,
        'type': 'Internal server error',
        'url': request.url,
        'message': extract_message(err)
    }), 500


# Import routes
# NOQA tells flake8 to ignore the import at the bottom of the file

from api.accounts import accounts_create    # NOQA

