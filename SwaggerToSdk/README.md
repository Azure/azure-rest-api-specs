The SwaggerToSDK script is the automation script launched at each commit on any Swagger files to provide:
- Testing against SDK language
- Automatic PR on each language SDK

This works is still in progress and move fast. We'll do our best to keep this page up-to-date.

# Configuration of the script

```bash
usage: SwaggerToSdk.py [-h] [--rest-folder RESTAPI_GIT_FOLDER]
                       [--pr-repo-id PR_REPO_ID] [--message MESSAGE]
                       [--base-branch BASE_BRANCH] [--branch BRANCH]
                       [--config CONFIG_PATH] [-v] [--debug]
                       sdk_git_id

Build SDK using Autorest and push to Github. The GH_TOKEN environment variable
needs to be set.

positional arguments:
  sdk_git_id            The SDK Github id. If a simple string, consider it
                        belongs to the GH_TOKEN owner repo. Otherwise, you can
                        use the syntax username/repoid

optional arguments:
  -h, --help            show this help message and exit
  --rest-folder RESTAPI_GIT_FOLDER, -r RESTAPI_GIT_FOLDER
                        Rest API git folder. [default: .]
  --pr-repo-id PR_REPO_ID
                        PR repo id. [default: None]
  --message MESSAGE, -m MESSAGE
                        Force commit message. {hexsha} will be the current
                        REST SHA1 [default: Generated from {hexsha}]
  --base-branch BASE_BRANCH, -o BASE_BRANCH
                        The base branch from where create the new branch.
                        [default: master]
  --branch BRANCH, -b BRANCH
                        The SDK branch to commit. Default if not Travis:
                        autorest. If Travis is detected, see epilog for
                        details
  --config CONFIG_PATH, -c CONFIG_PATH
                        The JSON configuration format path [default:
                        sdk_autogen_config.json]
  -v, --verbose         Verbosity in INFO mode
  --debug               Verbosity in DEBUG mode

If Travis is detected, --branch is setted by default to "RestAPI-PR{number}"
if triggered by a PR, "RestAPI-{branch}" otherwise
```

# Configuration file swagger_to_sdk.json

This is a configuration which MUST be at the root of the repository you wants to generate.

```json
{
  "meta": {
    "version":"0.1.0",
    "language": "Python",
    "autorest": "latest",
    "autorest_options": {
        "ft": 2,
        "AddCredentials": true
    }
  },
  "data": {
    "arm-authorization/2015-07-01/swagger/authorization.json": {
      "autorest_options": {
        "Namespace" : "azure.mgmt.authorization"
      },
      "output_dir": "azure-mgmt-authorization/azure/mgmt/authorization"
    },
  }
}
```

## Meta

### version
The version is not read yet, since this works is in progress. This could be use in the future to enable breaking changes detection and handling. Don't rely on this one for now

### language
The language parameter configure the language you want Autorest to generate. This could be (case-sensitive):
- Python
- CSharp
- Java
- NodeJS
- Ruby

This will trigger the Azure.<language> autorest code generator. Note that you can override this behaviour by specifying the "CodeGenerator" option in any "autorest_options" field.

### autorest
This the version to use from Autorest. Could be "latest" to download the latest nightly build. Could be a string like  '0.16.0-Nightly20160410' to download a specific version.
If node is not present, consider "latest".

## autorest_options
An optional dictionary of options you want to pass to Autorest. This will be passed in any call, but can be override by "autorest_options" in each data.
You can override the default `Azure.<language>` CodeGenerator parameter here (do NOT use "g" but "CodeGenerator").
Note that you CAN'T override "-i/-Input" and "-o/-Output" which are filled contextually.

## Data

It's a dict where keys are swagger path. Value are:

### autorest_options
A dictionary of options you want to pass to Autorest. This will override parameter from "autorest_options" in "meta" node.
You can override the default `Azure.<language>` CodeGenerator parameter here (do NOT use "g" but "CodeGenerator").
Note that you CAN'T override "-i/-Input" and "-o/-Output" which are filled contextually.

### output_dir

This is the folder in your SDK repository where you want to put the generated files.