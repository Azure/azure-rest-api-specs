# How to integrate test-proxy with API Scenario test

In this section, we'll show you how to make test-proxy recording with API Scenario test, assuming you've already learnt how to use API Scenario test. If not, please go to [QuickStart](./QuickStart.md).

Test-proxy is a tool that provides out-of-process record/playback capabilities compatible with any language. It also supports pushing/restoring the API test recordings from external git repository.

## Prerequisites

1. Install [test-proxy](https://github.com/Azure/azure-sdk-tools/blob/main/tools/test-proxy/Azure.Sdk.Tools.TestProxy/README.md#installation)

## Make a recording

1. Start test-proxy

```bash
test-proxy start
```

By default, it listens to 5000/5001 ports for http/https respectively.

2. Run API Scenario test

```bash
oav run <your-scenario-file>.yaml -e <your-env>.json --test-proxy http://localhost:5000
```

or

```bash
oav run --readme <your-readme>.md --tag <tag-name> --test-proxy http://localhost:5000
```

3. Check the recording file

The recording file can be found in the `recordings` folder.

## Playback a recording

TBA

## Push recording to external git repository

**Caution**: Please ensure no credentials in the recording file, before trying to push to external git repository.

1. Prepare assets.json file

The assets.json file is a configuration file used by test-proxy to push/restore recording to/from external git repository. Create an assets.json file under `scenarios/` folder with following content:

```json
{
  "AssetsRepo": "Azure/azure-sdk-assets",
  "AssetsRepoPrefixPath": "apitest",
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
│           ├── restler
│           │   ├── annotations.json
│           │   └── dict.json
│           └── scenarios
│               ├── assets.json         <----- check-in assets.json here
│               ├── basic.yaml
│               └── someArmTemplate.json
├── readme.go.md
├── readme.md
└── readme.test.md
```

2. Push recording to the git repository

```bash
test-proxy push -a ./Microsoft.AppConfiguration/stable/1.0/scenarios/assets.json
```