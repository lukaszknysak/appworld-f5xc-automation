def main():
    # Imports
    import os
    import logging.config
    from functions import api_call

    # Setup logging
    logging.config.fileConfig('logging_config.ini')

    # Constants
    TENANT = 'f5-amer-ent'
    
    ''' Main Function'''
    xc_api_token = os.environ.get("XC_API_TOKEN")
    headers = {'Authorization': f'APIToken {xc_api_token}'}
    namespace_url = f'https://{TENANT}.console.ves.volterra.io/api/web/namespaces/a-conley'
    status, response = api_call.api_call('get', namespace_url, headers=headers)
    if status:
        print(response.json())
    else:
        print(response.error)
    #all_namespaces_url = f'https://{TENANT}.console.ves.volterra.io/api/web/namespaces'
    #status, response = api_call.api_call('get', all_namespaces_url, headers=headers)
    #if status:
    #    print(f'all namespaces: {response.json()}')
    #else:
    #    print(response.error)
    #try:
    #    response = requests.get(f'https://{tenant}.console.ves.volterra.io/api/web/namespaces/a-conley', headers={'Authorization': f'APIToken {xc_api_token}'})
    #except requests.exceptions.RequestException as e:
    #    raise SystemExit(e)
    #print(response)
    #print(response.json())
    #print(json.dumps(response.json(), indent=2))

if __name__ == '__main__':
    main()