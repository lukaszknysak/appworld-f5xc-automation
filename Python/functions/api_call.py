import requests
import logging

logger = logging.getLogger(__name__)

def api_call (method, url, **kwargs):
    DEFAULT_REQUESTS_TIMEOUT = (5, 15)
    if 'timeout' not in kwargs:
        kwargs['timeout'] = DEFAULT_REQUESTS_TIMEOUT
    
    try:
        response = requests.request(method, url, **kwargs)
        logger.debug(f'method |{method}|\nurl {url}\nkwargs {kwargs}')
    except BaseException as exception:
        logger.debug(f'method |{method}|\nurl {url}\nkwargs {kwargs}')
        logger.debug(exception)
        return (False, exception)
    return (True, response)