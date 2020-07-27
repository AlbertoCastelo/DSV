import json
import os

BASE_CONFIGURATION_PATH = '/etc/opt/dsgit'
BASE_CONFIGURATION = {
    "repository": "dsgit",
    "dsgit_template_filaname": "dsgit/base-template.ipynb"
}


def read_configuration(filename):
    if os.path.isfile(filename):
        with open(filename) as json_file:
            return json.load(json_file) 
    
    # create file
    if not os.path.isdir(BASE_CONFIGURATION_PATH):
        os.mkdir(BASE_CONFIGURATION_PATH)

    with open(f'{BASE_CONFIGURATION_PATH}/dsgit_configuration.json', 'w') as json_file:
        json.dump(BASE_CONFIGURATION, json_file)
    return BASE_CONFIGURATION
