from github import Github
import os
import base64
import json

DS_REPO = 'data-science'
TEMPLATE_FILENAME = 'templates/ds-template.ipynb'


class DSGitCommand:
    def __init__(self):
        config = read_configuration(os.environ.get('DSGIT_CONFIGURATION_FILE', './dsgit_configuration.json'))
        
        self.user = os.environ['GITHUB_USER']
        token = os.environ['GITHUB_TOKEN']
        self.g = Github(self.user, token)

        # TO EXTRACT
        self.repo = config.get('repository')
        self.template_filename = config.get('dsgit_template_filaname')


    def get_template(self, local_directory='./'):
        self.download_file(repo=self.repo, repo_filename=self.template_filename, add_relativer_dir=False,
                           local_directory=local_directory)

    def download_file(self, repo, repo_filename, add_relativer_dir=True, local_directory='./'):
        repo = self.g.get_repo(f'{self.user}/{repo}')
        contents = repo.get_contents(repo_filename)
        str_ = base64ToString(contents.content)

        relative_dir, filename_simple = self._get_repo_filename_simple(repo_filename_complete=repo_filename)

        directory = f'{local_directory}'
        if add_relativer_dir:
            directory = f'{local_directory}{relative_dir}'

        self._save_file(data=str_, directory=directory, filename=filename_simple)

    def _get_repo_filename_simple(self, repo_filename_complete):
        split_ = repo_filename_complete.split('/')
        filename_simple = split_[-1]
        relative_dir = repo_filename_complete.replace(filename_simple, '')
        return relative_dir, filename_simple

    def _save_file(self, data: str, directory: str, filename: str):
        if not os.path.exists(directory):
            os.makedirs(directory)

        with open(f'{directory}/{filename}', 'w') as f:
            f.write(data)


def base64ToString(b):
    return base64.b64decode(b).decode('utf-8')


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
