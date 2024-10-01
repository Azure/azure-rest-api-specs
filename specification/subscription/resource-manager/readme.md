# Subscription

> see https://aka.ms/autorest

This is the AutoRest configuration file for Subscription.



---
## Getting Started
To build the SDK for Subscription, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Suppression
``` yaml
directive:
  - suppress: R2059
  - suppress: PutResponseCodes
    from: subscriptions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Subscription/changeTenantRequest/default"].put
    reason: Not supposed to return 201 as the response code for the below API since existing api with new version change, got exceptions from ARM reviewer.
  - suppress: PutRequestResponseSchemeArm
    from: subscriptions.json
    reason: The models designed in new version of this existing api in which put request, need not be same in response, but creating workitem - "https://msazure.visualstudio.com/One/_workitems/edit/29042001", to take this item in future ref for next set of changes.
  - suppress: LroExtension
    from: subscriptions.json
    where: $.paths["/providers/Microsoft.Subscription/subscriptionOperations/{operationId}"].get
    reason: Avoid Lro changes on this api to return 202.
  - suppress: GetOperation200
    from: subscriptions.json
    where: $.paths["/providers/Microsoft.Subscription/subscriptionOperations/{operationId}"].get.responses["202"]
    reason: This api will return 200 and 202 response.
  - suppress: DeleteResponseCodes
    from: subscriptions.json
    reason: The delete subscription changed directory expected to return 200 on every user's request, once it's deleted it will return 404, since it's a change on the existing api with new version, but creating workitem - "https://msazure.visualstudio.com/One/_workitems/edit/29188912", to refactor the call on delete request and will return 204 as no content in such cases to take this item in future ref.
  - suppress: DeleteOperationResponses
    from: subscriptions.json
    reason: The delete operation response for subscription changed directory expected to return 200 on every user's request, once it's deleted it will return 404, since it's a change on the existing api with new version, but creating workitem - "https://msazure.visualstudio.com/One/_workitems/edit/29188912", to refactor the call on delete request and will return 204 as no content in such cases to take this item in future ref.
```


### Basic Information
These are the global settings for the Subscription API.

``` yaml
openapi-type: arm
tag: package-2021-10
```

### Tag: package-2024-08-preview

These settings apply only when `--tag=package-2024-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-08-preview'
input-file:
- Microsoft.Subscription/preview/2024-08-01-preview/subscriptions.json
title: Initiate, Get and Accept Subscription Changed Directory
description: Initiate, Get and Accept Subscription Changed Directory
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
- Microsoft.Subscription/stable/2021-10-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` is specified on the command line.

``` yaml $(tag) == 'package-2020-09'
input-file:
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
- Microsoft.Subscription/stable/2020-09-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```

### Tag: package-2020-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01'
input-file:
- Microsoft.Subscription/stable/2020-01-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```

### Tag: package-2019-10-preview

These settings apply only when `--tag=package-2019-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-10-preview'
input-file:
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
- Microsoft.Subscription/preview/2019-10-01-preview/subscriptions.json
title: SubscriptionClient
description: The subscription client
```

### Tag: package-2019-03-preview

These settings apply only when `--tag=package-2019-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-03-preview'
input-file:
- Microsoft.Subscription/preview/2019-03-01-preview/subscriptions.json
- Microsoft.Subscription/preview/2018-11-01-preview/subscriptions.json
- Microsoft.Subscription/preview/2018-03-01-preview/operations.json
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```

### Tag: package-2018-11-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-11-preview'
input-file:
- Microsoft.Subscription/preview/2018-11-01-preview/subscriptions.json
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```

### Tag: package-2018-03-preview

These settings apply only when `--tag=package-2018-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-preview'
input-file:
- Microsoft.Subscription/preview/2018-03-01-preview/subscriptions.json
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```

### Tag: package-2017-11-preview

These settings apply only when `--tag=package-2017-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-11-preview'
input-file:
- Microsoft.Subscription/preview/2017-11-01-preview/subscriptionDefinitions.json
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.Python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.subscription
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-subscription
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2019-10-preview
  - tag: package-2017-11-preview
```

### Tag: package-2019-10-preview and java

These settings apply only when `--tag=package-2019-10-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.subscription.v2019_10_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/subscription/mgmt-v2019_10_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2017-11-preview and java

These settings apply only when `--tag=package-2017-11-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2017-11-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.subscription.v2017_11_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/subscription/mgmt-v2017_11_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-06-01

These settings apply only when `--tag=package-2016-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-06-01'
input-file:
- Microsoft.Subscription/stable/2016-06-01/subscriptions.json
title: SubscriptionClient
description: The subscription client
```




