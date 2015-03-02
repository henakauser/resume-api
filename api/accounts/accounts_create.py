from api import app, get_db_cursor
from api.lib.exception import pg_error_message
from api.lib.exception import InputError
from api.lib.pgutils import pg_result_to_dict
from api.lib.exception import validation_error_message
from api.lib.validation import validate_inputs
from flask import abort, request, jsonify
from psycopg2 import DatabaseError
from schematics.models import Model
from schematics.types import StringType

class Account(Model):
    """Validation inputs before inserting into the DB"""
    user_name = StringType(required=True, max_length=50)
    first_name = StringType(required=True, max_length=50)
    last_name = StringType(required=True, max_length=50)
    address = StringType(required=True, max_length=150)
    cell =  StringType(required=True, max_length=12)
    email = StringType(required=True, max_length=100)

@app.route('/accounts', methods=['POST'])
def create_account():
    """Create an account"""
    print 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    print request.get_json()
    print 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

    try:
        account = validate_inputs(Account, request.get_json())
    except InputError, err:
        app.logger.exception(err)
        abort(400, validation_error_message(err))

    json_keys = (
        'id',
        'user_name',
        'first_name',
        'last_name',
        'address',
        'cell',
        'email'
    )
    
    print 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    print account.to_native()
    with get_db_cursor(commit=True) as cursor:
        try:
            cursor.execute("""
                SELECT accounts_create (
                    %(user_name)s,
                    %(first_name)s,
                    %(last_name)s,
                    %(address)s,
                    %(cell)s,
                    %(email)s
                )
                """, account.to_native())
            result = cursor.fetchall()
        except DatabaseError as de:
            app.logger.error(de)
            abort(500, pg_error_message())

    return jsonify(pg_result_to_dict(json_keys, result, True)), 201
