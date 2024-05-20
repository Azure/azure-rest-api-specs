# Quick start with RESTler API testing tool

## Prerequisites

Install [Python 3.8.2][] and [.NET 6.0][] or higher, for your appropriate OS.

[Python 3.8.2]: https://www.python.org/downloads/
[.NET 6.0]:https://dotnet.microsoft.com/download/dotnet-core?utm_source=getdotnetcorecli&utm_medium=referral

## Install

Here are the steps to build and install RESTler locally.
See the [RESTler project readme][] for other installation options.

[RESTler project readme]: https://github.com/microsoft/restler-fuzzer/blob/main/README.md

```sh
git clone https://github.com/microsoft/restler-fuzzer.git
restler_bin=~/bin/restler
mkdir -p $restler_bin
# Need --python because it can’t find “python” — I use an alias that it did not understand.
python ./build-restler.py --dest_dir $restler_bin --python_path /opt/homebrew/bin/python3
```

## Create the initial Restler config and dict files

You need to create a Restler config file and a dict file for each API you want to test. You can use RESTler to create the initial files for you, with the `generateConfig` command. You need to specify the API spec file(s) -- here we use the Azure Databricks service as an example. 

```sh
specs=$(find /Users/mikekistler/Projects/Azure/azure-rest-api-specs/specification/databricks/resource-manager/Microsoft.Databricks/preview/2022-04-01-preview -type f -depth 1)
dotnet $restler_bin/restler/Restler.dll generate_config --specs ${=specs}
```

This creates a new directory `restlerConfig` with the following files:
- `annotations.json` - an empty file where you can add annotations for the API spec
- `config.json` - the Restler config file
- `dict.json` - a Restler dictionary file
- `engine_settings.json` - the Restler engine settings file  

## Customize the Restler configuration files

You often need to specify values for variables in the API definition.
You can do this by adding these values in `restler_custom_payload` property in the `dict.json` file.

For ARM APIs you generally need to specify the subscriptionId, resourceGroupName, and location.
You may also want to specify the api-version, in case an operation does not have an example value for it.
You can use the `jq` command to add these values. Here is an example:

```sh
vars='{
    "subscriptionId": ["my-subscription-id"],
    "resourceGroupName": ["my-resource-group"],
    "location": ["my-location"],
    "api-version": ["2022-04-01-preview"]
}'
jq ".restler_custom_payload = $vars" restlerConfig/dict.json > dict.json
```

No changes are needed to `config.json`, `annotations.json`, or `engine_settings.json`, so you can just copy them from the `restlerConfig` directory.

```sh
cp restlerConfig/config.json .
cp restlerConfig/annotations.json .
cp restlerConfig/engine_settings.json .
```

## Compile tne new configuration

```sh
dotnet $restler_bin/restler/Restler.dll compile config.json
```

This creates a new directory `Compile` with many files.

## Set up the authentication script

One last piece to put in place is the script that will supply RESTler with the authentication token.
For Azure services that accept AAD tokens, you can use the following script (called `getToken.sh`),
which uses the [Azure CLI][] to get the token.

```sh
#!/bin/bash

find . -name 'token.json' -depth 1 -mtime -1h | grep . &> /dev/null || az account get-access-token > token.json

token=$(jq -r '.accessToken' token.json)

echo "{'user1':{}}"
echo "Authorization: bearer ${token}"
```

You might need to modify this script to specify a specific AAD scope on the get-access-token command.

Don't forget to make the script executable.

## Run the tests

Now you are ready to run the Test phase of Restler.

```sh
dotnet $restler_bin/restler/Restler.dll test --dictionary_file Compile/dict.json --grammar_file Compile/grammar.py --settings Compile/engine_settings.json --token_refresh_command "bash $PWD/getToken.sh" --token_refresh_interval 60
```

In most cases the tests will take no more than a few minutes to run and display results that look like:

```text
Starting task Test...
Using python: 'python3' (Python 3.10.9)
Request coverage (successful / total): 9 / 24
Attempted requests: 10 / 24
No bugs were found.
See 'coverage_failures_to_investigate.txt' to investigate API coverage.
Task Test succeeded.
Collecting logs...
```

The time required to run the tests depends on the number and operations and complexity of the dependency graph,
and for a very large service API it may be several hours.

## Analyze the results

If any tests failed or were not attempted, you will need to dig into the test results to understand why.

Some common reasons for failures are:
- The request body may contain values that must be customized for your environment,
for example a `tenantId` or a reference to another resource in your environment.

If there are operations that were not attempted, that happens when RESTler has determined that these operations
depend on some other operation, perhaps indirectly, that failed.
RESTler produces a file called `coverage_failures_to_investigate.txt` that lists the failed operations and which
dependent operations were not attempted because of this.

## Make fixes and re-run

Once you have found the cause of the failures, you can make changes to the config files and re-run the tests.
However, be sure to re-compile the config files before re-running the tests -- it's easy to forget this step.
