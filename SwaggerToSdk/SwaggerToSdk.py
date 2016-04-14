"""Swagger to SDK"""
import platform
import shutil
import os
import stat
import subprocess
import logging
import tempfile
import argparse
import json
import zipfile
import re
from io import BytesIO
from pathlib import Path
from contextlib import contextmanager

import requests
from git import Repo, GitCommandError
from github import Github, GithubException

_LOGGER = logging.getLogger(__name__)

LATEST_TAG = 'latest'
AUTOREST_BASE_DOWNLOAD_LINK = "https://www.myget.org/F/autorest/api/v2/package/autorest/"

CONFIG_FILE = 'swagger_to_sdk_config.json'
NEEDS_MONO = platform.system() != 'Windows'

DEFAULT_BRANCH_NAME = 'autorest'
DEFAULT_TRAVIS_PR_BRANCH_NAME = 'RestAPI-PR{number}'
DEFAULT_TRAVIS_BRANCH_NAME = 'RestAPI-{branch}'

IS_TRAVIS = os.environ.get('TRAVIS') == 'true'


def read_config(sdk_git_folder):
    """Read the configuration file and return JSON"""
    config_path = os.path.join(sdk_git_folder, CONFIG_FILE)
    with open(config_path, 'r') as config_fd:
        return json.loads(config_fd.read())


def download_install_autorest(output_dir, autorest_version=LATEST_TAG):
    """Download and install Autorest in the given folder"""
    download_link = AUTOREST_BASE_DOWNLOAD_LINK
    if autorest_version != LATEST_TAG:
        download_link += autorest_version

    _LOGGER.info("Download Autorest from: %s", download_link)
    try:
        downloaded_package = requests.get(download_link)
    except:
        msg = "Unable to download Autorest for '{}', " \
                "please check this link and/or version tag: {}".format(
                    autorest_version,
                    download_link
                )
        _LOGGER.critical(msg)
        raise ValueError(msg)
    if downloaded_package.status_code != 200:
        raise ValueError(downloaded_package.content.decode())
    _LOGGER.info("Downloaded")
    with zipfile.ZipFile(BytesIO(downloaded_package.content)) as autorest_package:
        autorest_package.extractall(output_dir)
    return os.path.join(output_dir, 'tools', 'AutoRest.exe')


def generate_code(language, swagger_file, output_dir, autorest_exe_path, autorest_conf=''):
    """Call the Autorest process with the given parameters"""
    if NEEDS_MONO:
        autorest_exe_path = 'mono ' + autorest_exe_path
    cmd_line = "{} -AddCredentials true -ft 2 -g Azure.{} " \
                "-i {} -o {} {}"
    cmd_line = cmd_line.format(autorest_exe_path,
                               language,
                               swagger_file,
                               output_dir,
                               autorest_conf)
    _LOGGER.debug("Autorest cmd line:\n%s", cmd_line)

    try:
        result = subprocess.check_output(cmd_line.split(),
                                         stderr=subprocess.STDOUT,
                                         universal_newlines=True)
    except subprocess.CalledProcessError as err:
        _LOGGER.error(err)
        _LOGGER.error(err.output)
        raise
    except Exception as err:
        _LOGGER.error(err)
        raise
    else:
        _LOGGER.info(result)


def get_swagger_hexsha(restapi_git_folder):
    """Get the SHA1 of the current repo"""
    repo = Repo(restapi_git_folder)
    if repo.bare:
        not_git_hexsha = "notgitrepo"
        _LOGGER.warning("Not a git repo, SHA1 used will be: %s", not_git_hexsha)
        return not_git_hexsha
    hexsha = repo.head.commit.hexsha
    _LOGGER.info("Found REST API repo SHA1: %s", hexsha)
    return hexsha


def update(language, generated_folder, destination_folder):
    """Update data from generated to final folder"""
    if language == 'Python':
        update_python(generated_folder, destination_folder)
    else:
        update_generic(generated_folder, destination_folder)

def update_python(generated_folder, destination_folder):
    """Update data from generated to final folder, Python version"""
    client_generated_path = next(Path(generated_folder).glob('*client'))

    # Specific code for batch currently
    batch_auth_file = Path(destination_folder, 'batch_auth.py')
    if batch_auth_file.exists():
        batch_auth_file_dest = client_generated_path.joinpath('batch_auth.py')
        shutil.copy(str(batch_auth_file), str(batch_auth_file_dest))

    client_generated_path.joinpath('credentials.py').unlink()
    client_generated_path.joinpath('exceptions.py').unlink()

    shutil.rmtree(destination_folder)
    client_generated_path.replace(destination_folder)


def update_generic(generated_folder, destination_folder):
    """Update data from generated to final folder.
       Generic version which just copy the files"""
    client_generated_path = Path(generated_folder)
    shutil.rmtree(destination_folder)
    client_generated_path.replace(destination_folder)


def checkout_and_create_branch(repo, name):
    """Checkout branch. Create it if necessary"""
    local_branch = repo.branches[name] if name in repo.branches else None
    if not local_branch:
        if name in repo.remotes.origin.refs:
            # If origin branch exists but not local, git.checkout is the fatest way
            # to create local branch with origin link automatically
            msg = repo.git.checkout(name)
            _LOGGER.debug(msg)
            return
        # Create local branch, will be link to origin later
        local_branch = repo.create_head(name)
    local_branch.checkout()


def compute_branch_name(branch_name):
    """Compute the branch name depended on Travis, default or not"""
    if branch_name:
        return branch_name
    if not IS_TRAVIS:
        return DEFAULT_BRANCH_NAME
    _LOGGER.info("Travis detected")
    pr_number = os.environ['TRAVIS_PULL_REQUEST']
    if pr_number == 'false':
        return DEFAULT_TRAVIS_BRANCH_NAME.format(branch=os.environ['TRAVIS_BRANCH'])
    return DEFAULT_TRAVIS_PR_BRANCH_NAME.format(number=pr_number)


def commit_and_push(repo, message_template, branch_name, hexsha):
    """Create commit with all untracked/modified files and push it """

    if not repo.git.diff():
        _LOGGER.warning('No modified files in this Autorest run')
        return False
    repo.git.add(repo.working_tree_dir)

    checkout_and_create_branch(repo, branch_name)
    msg = message_template.format(hexsha=hexsha)
    repo.index.commit(msg)
    _LOGGER.info("Commit done: %s", msg)
    repo.git.push('origin', branch_name, set_upstream=True)
    return True


def do_pr(gh_token, sdk_git_id, sdk_pr_target_repo_id, branch_name, base_branch):
    "Do the PR"
    if not gh_token:
        _LOGGER.info('Skipping the PR, no token found')
        return

    github_con = Github(gh_token)
    sdk_pr_target_repo = github_con.get_repo(sdk_pr_target_repo_id)

    if '/' in sdk_git_id:
        sdk_git_owner = sdk_git_id.split('/')[0]
        _LOGGER.info("Do the PR from %s", sdk_git_owner)
        head_name = "{}:{}".format(sdk_git_owner, branch_name)
    else:
        head_name = branch_name

    body = ''
    rest_api_pr = get_pr_object_from_travis(gh_token)
    if rest_api_pr:
        body += "Generated from RestAPI PR: {}".format(rest_api_pr.html_url)
    try:
        github_pr = sdk_pr_target_repo.create_pull(
            title='Automatic PR from {}'.format(branch_name),
            body=body,
            head=head_name,
            base=base_branch
        )
    except GithubException as err:
        if err.status == 422 and err.data['errors'][0]['message'].startswith('A pull request already exists'):
            _LOGGER.info('PR already exists, it was a commit on an open PR')
            return
        raise
    _LOGGER.info("Made PR %s", github_pr.html_url)
    comment = compute_pr_comment_with_sdk_pr(github_pr.html_url, sdk_git_id, branch_name)
    add_comment_to_initial_pr(gh_token, comment)


def get_pr_object_from_travis(gh_token):
    """If Travis, return the Github object representing the PR.
       If result is None, is not Travis.
       Might raise if Travis
    """
    if not IS_TRAVIS:
        return
    pr_number = os.environ['TRAVIS_PULL_REQUEST']
    if pr_number == 'false':
        _LOGGER.info("This build don't come from a PR")
        return
    github_con = Github(gh_token)
    github_repo = github_con.get_repo(os.environ['TRAVIS_REPO_SLUG'])

    return github_repo.get_issue(int(pr_number))

def compute_pr_comment_with_sdk_pr(comment, sdk_fork_id, branch_name):
    travis_string = "[![Build Status]"\
                        "(https://travis-ci.org/{fork_repo_id}.svg?branch={branch_name})]"\
                        "(https://travis-ci.org/{fork_repo_id})"
    travis_string = travis_string.format(branch_name=branch_name,
                                         fork_repo_id=sdk_fork_id)
    return travis_string+' '+comment

def get_pr_from_travis_commit_sha(gh_token):
    """Try to determine the initial PR using #<number> in the current commit comment.
    Will check if the found number is really a merged PR"""
    if not gh_token:
        return
    github_con = Github(gh_token)
    github_repo = github_con.get_repo(os.environ['TRAVIS_REPO_SLUG'])

    local_commit = github_repo.get_commit(os.environ['TRAVIS_COMMIT'])
    commit_message = local_commit.commit.message
    issues_in_message = re.findall('#([\\d]+)', commit_message)

    issue_object = None
    for issue in issues_in_message:
        try:
            _LOGGER.info('Check if %s is a PR', issue)
            issue_object = github_repo.get_pull(int(issue))
            if not issue_object.is_merged():
                continue
            break
        except Exception as err:
            pass
    if not issue_object:
        _LOGGER.warning('Was not able to found PR commit message')
    return issue_object

def add_comment_to_initial_pr(gh_token, comment):
    "Add a comment to the initial PR"
    if not gh_token:
        return
    initial_pr = get_pr_object_from_travis(gh_token)
    if not initial_pr:
        initial_pr = get_pr_from_travis_commit_sha(gh_token)
    if not initial_pr:
        return
    initial_pr.create_comment(comment)

def user_login_from_token(gh_token):
    """Get user login from GitHub token"""
    github_con = Github(gh_token)
    return github_con.get_user().login

def sync_fork(gh_token, github_repo_id, repo):
    """Sync the current branch in this fork against the direct parent on Github"""
    if not gh_token:
        _LOGGER.warning('Skipping the upstream repo sync, no token')
        return
    _LOGGER.info('Check if repo has to be sync with upstream')
    github_con = Github(gh_token)
    github_repo = github_con.get_repo(github_repo_id)

    upstream_url = 'https://github.com/{}.git'.format(github_repo.parent.full_name)
    upstream = repo.create_remote('upstream', url=upstream_url)
    upstream.fetch()
    active_branch_name = repo.active_branch.name
    if not active_branch_name in repo.remotes.upstream.refs:
        _LOGGER.info('Upstream has no branch %s to merge from', active_branch_name)
        return
    else:
        _LOGGER.info('Merge from upstream')
    msg = repo.git.merge('upstream/{}'.format(repo.active_branch.name))
    _LOGGER.debug(msg)
    msg = repo.git.push()
    _LOGGER.debug(msg)


def get_full_sdk_id(gh_token, sdk_git_id):
    """If the SDK git id is incomplete, try to complete it with user login"""
    if not '/' in sdk_git_id:
        user = user_login_from_token(gh_token)
        return '{}/{}'.format(user, sdk_git_id)
    return sdk_git_id

def clone_to_path(gh_token, temp_dir, sdk_git_id):
    """Clone the given repo_id to the 'sdk' folder in given temp_dir"""
    _LOGGER.info("Clone SDK repository %s", sdk_git_id)

    credentials_part = ''
    if gh_token:
        user = user_login_from_token(gh_token)
        credentials_part = '{user}:{token}@'.format(
            user=user,
            token=gh_token
        )
    else:
        _LOGGER.warning('Will clone the repo without writing credentials')

    https_authenticated_url = 'https://{credentials}github.com/{sdk_git_id}.git'.format(
        credentials=credentials_part,
        sdk_git_id=sdk_git_id
    )
    sdk_path = os.path.join(temp_dir, 'sdk')
    Repo.clone_from(https_authenticated_url, sdk_path)
    _LOGGER.info("Clone success")

    return sdk_path

def remove_readonly(func, path, _):
    "Clear the readonly bit and reattempt the removal"
    os.chmod(path, stat.S_IWRITE)
    func(path)

@contextmanager
def manage_sdk_folder(gh_token, temp_dir, sdk_git_id):
    """Context manager to avoid readonly problem while cleanup the temp dir"""
    sdk_path = clone_to_path(gh_token, temp_dir, sdk_git_id)
    _LOGGER.debug("SDK path %s", sdk_path)
    try:
        yield sdk_path
        # Pre-cleanup for Windows http://bugs.python.org/issue26660
    finally:
        _LOGGER.debug("Preclean SDK folder")
        shutil.rmtree(sdk_path, onerror=remove_readonly)


def build_libraries(gh_token, restapi_git_folder, sdk_git_id, pr_repo_id, message_template, base_branch_name, branch_name):
    """Main method of the the file"""
    sdk_git_id = get_full_sdk_id(gh_token, sdk_git_id)
    branch_name = compute_branch_name(branch_name)
    _LOGGER.info('Destination branch for generated code is %s', branch_name)

    with tempfile.TemporaryDirectory() as temp_dir, \
            manage_sdk_folder(gh_token, temp_dir, sdk_git_id) as sdk_folder:

        sdk_repo = Repo(sdk_folder)
        try:
            _LOGGER.info('Try to checkout the destination branch if it already exists')
            sdk_repo.git.checkout(branch_name)
        except GitCommandError:
            _LOGGER.info('Destination branch does not exists')
            sdk_repo.git.checkout(base_branch_name)

        sync_fork(gh_token, sdk_git_id, sdk_repo)
        config = read_config(sdk_repo.working_tree_dir)

        language = config["meta"]["language"]
        hexsha = get_swagger_hexsha(restapi_git_folder)

        autorest_temp_dir = os.path.join(temp_dir, 'autorest')
        os.mkdir(autorest_temp_dir)

        autorest_exe_path = download_install_autorest(autorest_temp_dir, config["meta"]["autorest"])

        for file, conf in config["data"].items():
            _LOGGER.info("Working on %s", file)
            dest = conf['output_dir']
            autorest_conf = conf['autorest_options']
            swagger_file = os.path.join(restapi_git_folder, file)
            dest_folder = os.path.join(sdk_repo.working_tree_dir, dest)

            if not os.path.isfile(swagger_file):
                err_msg = "Swagger file does not exist or is not readable: {}".format(
                    swagger_file)
                _LOGGER.critical(err_msg)
                raise ValueError(err_msg)

            if not os.path.isdir(dest_folder):
                err_msg = "Dest folder does not exist or is not accessible: {}".format(
                    dest_folder)
                _LOGGER.critical(err_msg)
                raise ValueError(err_msg)

            generated_path = os.path.join(temp_dir, os.path.basename(file))
            generate_code(language,
                          swagger_file, generated_path,
                          autorest_exe_path, autorest_conf)
            update(language, generated_path, dest_folder)

        if gh_token:
            if commit_and_push(sdk_repo, message_template, branch_name, hexsha):
                do_pr(gh_token, sdk_git_id, pr_repo_id, branch_name, base_branch_name)
            else:
                add_comment_to_initial_pr(gh_token, "No modification for {}".format(language))
        else:
            _LOGGER.warning('Skipping commit creation since no token is provided')

    _LOGGER.info("Build SDK finished and cleaned")


def main():
    """Main method"""
    parser = argparse.ArgumentParser(
        description='Build SDK using Autorest and push to Github. The GH_TOKEN environment variable needs to be set.',
        epilog='If Travis is detected, --branch is setted by default to "{}" if triggered by a PR, "{}" otherwise'.format(
            DEFAULT_TRAVIS_PR_BRANCH_NAME,
            DEFAULT_TRAVIS_BRANCH_NAME
        ))
    parser.add_argument('--rest-folder', '-r',
                        dest='restapi_git_folder', default='.',
                        help='Rest API git folder. [default: %(default)s]')
    parser.add_argument('--pr-repo-id',
                        dest='pr_repo_id', default=None,
                        help='PR repo id. [default: %(default)s]')
    parser.add_argument('--message', '-m',
                        dest='message', default='Generated from {hexsha}',
                        help='Force commit message. {hexsha} will be the current REST SHA1 [default: %(default)s]')
    parser.add_argument('--base-branch', '-o',
                        dest='base_branch', default='master',
                        help='The base branch from where create the new branch. [default: %(default)s]')
    parser.add_argument('--branch', '-b',
                        dest='branch', default=None,
                        help='The SDK branch to commit. Default if not Travis: {}. If Travis is detected, see epilog for details'.format(DEFAULT_BRANCH_NAME))
    parser.add_argument('--config', '-c',
                        dest='config_path', default='sdk_autogen_config.json',
                        help='The JSON configuration format path [default: %(default)s]')
    parser.add_argument("-v", "--verbose",
                        dest="verbose", action="store_true",
                        help="Verbosity in INFO mode")
    parser.add_argument("--debug",
                        dest="debug", action="store_true",
                        help="Verbosity in DEBUG mode")

    parser.add_argument('sdk_git_id',
                        help='The SDK Github id. '\
                         'If a simple string, consider it belongs to the GH_TOKEN owner repo. '\
                         'Otherwise, you can use the syntax username/repoid')

    args = parser.parse_args()

    if 'GH_TOKEN' not in os.environ:
        gh_token = None
    else:
        gh_token = os.environ['GH_TOKEN']

    main_logger = logging.getLogger()
    if args.verbose or args.debug:
        logging.basicConfig()
        main_logger.setLevel(logging.DEBUG if args.debug else logging.INFO)

    build_libraries(gh_token,
                    args.restapi_git_folder, args.sdk_git_id,
                    args.pr_repo_id,
                    args.message, args.base_branch, args.branch)

if __name__ == "__main__":
    main()
