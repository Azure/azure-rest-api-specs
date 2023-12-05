# How to use RESTler and test-proxy to make traffic recording

In this section, we'll show you how to generate a traffic recording with [RESTler][] and the
[Azure SDK Tools Test Proxy][] and save it to the azure-sdk-assets git repository.
For information on how to run RESTler, please go to [QuickStart](./QuickStart.md).

The Azure SDK Tools Test Proxy is a tool that provides out-of-process record/playback capabilities compatible with any language.
It also supports pushing/restoring the API test recordings from a git repository.
Traffic recordings can be used to validate that the REST API definition is consistent with service behavior.

[RESTler]: https://github.com/microsoft/restler-fuzzer
[Azure SDK Tools Test Proxy]: https://github.com/Azure/azure-sdk-tools/blob/main/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md

## Install the test-proxy

See [how to install test-proxy](https://github.com/Azure/azure-sdk-tools/blob/main/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md#installation)

## Prepare assets.json file

The assets.json file is a configuration file used by the test-proxy to push/restore recording to/from a git repository.
Create an assets.json file with following content:

```json
{
  "AssetsRepo": "Azure/azure-sdk-assets",
  "AssetsRepoPrefixPath": "",
  "TagPrefix": "apitest/<ServiceName>/<package>"
}
```

Take the appConfiguration data-plane API as an example:
- ServiceName="appconfiguration"
- package="dataplane"

So the contents of `assets.json` should look like:
```json
{
  "AssetsRepo": "Azure/azure-sdk-assets",
  "AssetsRepoPrefixPath": "apitest",
  "TagPrefix": "apitest/appconfiguration/dataplane",
}
```

Place this file in the `scenarios/` folder under the API version being tested.

```
specification/appconfiguration/data-plane
├── Microsoft.AppConfiguration
│   └── stable
│       └── 1.0
│           ├── appconfiguration.json
│           ├── examples
│           │   ├── CheckKeyValue.json
│           │   ├── PutLock.json
│           │   └── PutLock_IfMatch.json
│           └── scenarios
│               └── assets.json         <----- check-in assets.json here
└── readme.md
```

## Start the test-proxy

Open a new terminal window, cd to root of azure-rest-api-specs, and start test-proxy in this directory

```bash
test-proxy start
```

## Update the RESTler configuration file to use test-proxy

The general instructions for running RESTler can be found [here](./QuickStart.md).
There are some specific instructions for running RESTler with test-proxy.

### Update engineSettings.json

You need to modify the `engineSettings.json` file to use the test-proxy.

```sh
jq '.host = "localhost" | .target_port = 5000 | .no_ssl = true' restlerConfig/engine_settings.json > engine_settings.json
```

### Update the Restler custom dictionary with test-proxy headers

The test-proxy requires custom headers to be sent with each request that tell it how to handle the request.
One of these headers specifies the "recording id", which is obtained by sending a request to the test-proxy to start a new recording session.

To start a recording session, send a `/Record/Start` request to the test-proxy.
The request should specify the name of the recording file and the path to the `assets.json` file.
The recording file will be created in the `.assets` folder in the root of the azure-rest-api-specs repo,
but must have a unique name to avoid conflicts with other recordings.
Here we make the name unique by prepending the same path as the `assets.json` file.
The response of this request will contain an "x-recording-id" header. Save the value in `recording_id` variable.

```sh
scenarios=specifications/appconfiguration/data-plane/Microsoft.AppConfiguration/stable/1.0/scenarios
body='{ 
  "x-recording-file": "'${scenarios}'/recording.json",
  "x-recording-assets-file": "'${scenarios}'/assets.json"
}'
recording_id=$(curl -X POST -s -D - -d ${body} http://localhost:5000/Record/Start | grep 'x-recording-id' | awk '{print $2}' | sed 's/\r$//')
```

Now you can update the custom dictionary with the recording id and [the test-proxy headers](https://github.com/Azure/azure-sdk-tools/blob/main/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md#run-your-tests):
- `x-recording-upstream-base-uri`: the base URI of the upstream service
- `x-recording-id`: the recording id obtained from the test-proxy
- `x-recording-mode`: the recording mode, which should be `record` for recording

```sh
headers='{                                                 
  "x-recording-upstream-base-uri": ["https://management.azure.com"],
  "x-recording-id": ["'${recording_id}'"],
  "x-recording-mode": ["record"]
}'
jq ".restler_custom_payload_header = $headers" dict.json > tmp.json && mv tmp.json dict.json 
```

### Recompile the configuration

Now recompile the configuration to incorporate these changes.

```sh
dotnet $restler_bin/restler/Restler.dll compile config.json
```

## Run the tests

Run the tests as describe in [QuickStart](./QuickStart.md#run-the-tests).

## Stop the recording

Once the tests have completed, stop the recording session by sending a `/Record/Stop` request to the test-proxy.
```
curl -X POST -D - -H  "x-recording-id: ${recording_id}" -H 'Content-Length: 0' http://localhost:5000/Record/Stop
```

Return to the terminal window where the test-proxy is running and press `Ctrl+C` to stop the test-proxy.

The recording file can be found in the `.assets` folder.

```sh
find .assets -name recording.json
```

## Upload the Recording

Check the recording file to ensure that all secrets have been removed.
If any secrets are found, see the [Test Proxy documentation](https://github.com/Azure/azure-sdk-tools/blob/main/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md#session-and-test-level-transforms-sanitizers-and-matchers)
for information on how to construct a custom sanitizer.

After ensuring that all secrets have been removed, push the recording to the azure-sdk-assets git repository.
From the root of the azure-rest-api-specs repo, run the command:

```bash
test-proxy push -a <path to assets.json>
```

## Add assets.json for recording to azure-rest-api-specs

After pushing the recording, the test-proxy should write the latest git tag to assets.json file.
But check the assets.json file and if the "Tag" property is not set, set it to the git tag from the output of the push command.
Then commit the updated assets.json file and submit a PR to the azure-rest-api-specs repo.

```sh
git checkout -b apitest-appconfiguration-assets
git add <path to assets.json>
git commit -m "Add assets.json file for appconfiguration data-plane test recording."
git push origin HEAD
```

## Update the recording

If you need to update the recording ...

## Playback recording

TBA
