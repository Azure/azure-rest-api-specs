<!--
 Copyright (c) 2021 Microsoft Corporation

 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

# API test quick start

## Install

`oav` is an open source powerful tool for swagger validation, example generation, and api testing. GitHub: https://github.com/Azure/oav.

```sh
npm install -g oav@latest
```

## Create AAD app

To run api test, first please prepare an AAD app which is used for provisioning Azure resource. Please grant subscription contributor permission to this AAD app.

## Authoring step

We will write test scenario for SignalR service.

#### 1. Write your first test scenario file

First, create a folder `test-scenarios` under the api version folder. All test scenario files under the `test-scenarios` folder should bind with the api version.

![](./folder-structure.png)

Now write your basic test scenario.

```yaml
scope: ResourceGroup
testScenarios:
  - description: Microsoft.SignalRService/signalR SignalR_CreateOrUpdate
    steps:
      - step: SignalR_CreateOrUpdate
        exampleFile: ../examples/SignalR_CreateOrUpdate.json
      - step: SignalR_Delete
        exampleFile: ../examples/SignalR_Delete.json
```

#### 2. create your env file

The `env.json` file contains required test scenario variables such as, subscriptionId, AAD applicationId, AAD applicationSecret.

```json
{
  "subscriptionId": "<my subscription id>",
  "location": "westus",
  "tenantId": "AAD app tenantId",
  "client_id": "my add client_id",
  "client_secret": "<my aad client_secret>"
}
```

#### 3. Run api test

```sh
oav run-test-scenario /home/user/<xxx>/azure-rest-api-specs/specification/signalr/resource-manager/Microsoft.SignalRService/preview/2020-07-01-preview/test-scenarios/signalR.yaml -e env.json
```
