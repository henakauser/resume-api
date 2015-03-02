"""Custom exceptions"""
from api.lib.strings import NOT_FOUND_ERROR
from api.lib.strings import POSTGRESQL_DATABASE_ERROR
from api.lib.strings import VALIDATION_ERROR


class InputError(Exception):
    """
    Error raised when input(s) fail validation during model conversion or
    validation.
    """
    pass


def abort_message(message):
    """Generic abort message"""
    return {'message': message}


def pg_error_message():
    """Generic PostgreSQL internal database error."""
    return abort_message(POSTGRESQL_DATABASE_ERROR)


def validation_error_message(err):
    """Standard error for validation errors."""
    return {'message': VALIDATION_ERROR, 'validation': err}


def not_found_message():
    """Resource not found in database."""
    return abort_message(NOT_FOUND_ERROR)
