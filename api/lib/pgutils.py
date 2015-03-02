"""PostgreSQL utilities"""


def pg_result_to_dict(columns, result, single_object=False):
    """Convert a PostgreSQL query result to a dict"""
    resp = []
    for row in result:
        resp.append(dict(zip(columns, row)))

    if single_object:
        return resp[0]

    return resp
