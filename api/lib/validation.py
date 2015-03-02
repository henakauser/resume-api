"""Custom validation"""

from api.lib.exception import InputError
from schematics.exceptions import ModelConversionError
from schematics.exceptions import ModelValidationError
from schematics.exceptions import ValidationError
from schematics.types import StringType


class UppercaseStringType(StringType):
    """Example of a custom validation type"""
    def validate_uppercase(self, value):
        # Do not make this a static method!
        if value.upper() != value:
            raise ValidationError('String must be all uppercase.')


def validate_inputs(schema, input_data):
    """
    Validate inputs to a controller. Consolidate multiple potential exceptions
    into the InputError exception. Return either the validated input object or
    an exception.
    """
    try:
        inputs = schema(input_data)
        inputs.validate()
    except ModelConversionError, mce:
        raise InputError(mce.messages)
    except ModelValidationError, mve:
        raise InputError(mve.messages)

    return inputs
