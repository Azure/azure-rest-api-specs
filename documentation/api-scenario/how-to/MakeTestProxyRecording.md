# How to use API Scenario Test and test-proxy to make traffic recording

In this section, we'll show you how to make traffic recording with API Scenario Test and test-proxy, assuming you've already learnt how to use API Scenario test. If not, please go to [QuickStart](./QuickStart.md).

Test-proxy is a tool that provides out-of-process record/playback capabilities compatible with any language. It also supports pushing/restoring the API test recordings from external git repository. Traffic recording can be an evidence of running API test, and also help validate Swagger consistency. See [how to install test-proxy](https://github.com/Azure/azure-sdk-tools/blob/main/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md#installation)

## Prepare assets.json file

The assets.json file is a configuration file used by test-proxy to push/restore recording to/from external git repository. Create an assets.json file under `scenarios/` folder with following content:

```json
{
  "AssetsRepo": "Azure/azure-sdk-assets",
  "AssetsRepoPrefixPath": "",
  "TagPrefix": "apitest/<ServiceName>/<package>"
}
```

Take appConfiguration as an example,

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

## Make recording

1. Start test-proxy under the repository root folder

```bash
test-proxy start
```

By default, it listens to 5000/5001 ports for http/https respectively.

2. Run API Scenario test

```bash
oav run <your-scenario-file>.yaml -e <your-env>.json --testProxy http://localhost:5000 --testProxyAssets <your-assets-file>.json
```

3. Check the recording file

The recording file can be found in the `<repository-root>/.assets` folder.

## Push recording

1. Delete secrets from recording files

Please ensure no secrets in the recording file, before trying to push to external git repository.

2. Push recording to the git repository

```bash
test-proxy push -a <your-assets-file>.json
```

3. Commit updated assets.json file

After pushing the recording, test-proxy will write the latest git tag to assets.json file. Check the content of recording on github assets repository if as expected. If no problem, commit and push the updated assets.json file.

## Restore recording

Use following command to fetch recording:

```bash
test-proxy restore -a <your-assets-file>.json
```

or reset if any weird thing happens:

```bash
test-proxy reset -a <your-assets-file>.json
```
## Playback recording

TBA
