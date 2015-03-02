"""General purpose utilities"""


def merge_dicts(inputs):
    """
    Merge multiple input dicts into a single dict.

    Parameters
    ----------
    inputs : list
        List of dictionaries.
    """
    output = {}
    for i in inputs:
        output.update(i)
    return output


def query_string_to_dict(request):
    """Extract the query string from the request and return it as a dict."""
    query_string = {}
    for pair in request.args.items():
        query_string.update({pair[0]: pair[1]})
    return query_string
