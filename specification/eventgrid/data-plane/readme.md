# EventGrid

> see https://aka.ms/autorest

This is the AutoRest configuration file for EventGrid.


Multiple Azure services publish events to Azure Event Grid. This is the configuration file for generating
the Publish API and the schemas for those events. Each Azure service publishing to Azure Event Grid has its own tag OpenAPI specification
that describes the schemas for its events.

This configuration enables packaging all of the above as one EventGrid data plane library.
This enables customers to download one EventGrid data plane library instead of having to install separate packages to get the event schemas for each service.

### Guidelines for defining a new event 

In order to automate the mapping of event definition with event type, please follow the guidelines below when adding new events to your swagger:
- The name of a new event definition should have `EventData` suffix. For e.g. `AcsChatMessageReceivedEventData`.
- The description of the new event should include the event type. This is the `eventType` name in an `EventGridEvent` or `type` name in `CloudEvent`. For e.g. `"Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event.` Here `Microsoft.Communication.ChatMessageReceived` is the event name.

A sample valid event definition is shown below:
~~~ markdown
```json
"AcsChatMessageReceivedEventData": {
  "description": "Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event.",
  "allOf": [
    {
      "$ref": "#/definitions/AcsChatMessageEventBaseProperties"
    }
  ],
  "properties": {
    "messageBody": {
      "description": "The body of the chat message",
      "type": "string"
    }
  }
}
```
~~~

In addition to the event schema definition, you must provide a JSON example of a real event the service can trigger. This example must be in a "examples" folder close to your JSON, and called using snakeCase based on the event final name. The example should contain the envelope, but could be CloudEvent or EventGrid schema, whatever is easier. Example should NOT be handcrafted, but an actual result from a server test environment like canary (it's not required that the event is deployed in production yet). No PR will be accepted without the example.

For the previous schema, the example file should be called "chat_message_received.json" and contains:
~~~ markdown
```json
{
    "id": "02272459-badb-4e2e-b538-4cb8a2f71da6",
    "topic": "/subscriptions/{subscription-id}/resourceGroups/{group-name}/providers/Microsoft.Communication/communicationServices/{communication-services-resource-name}",
    "subject": "thread/{thread-id}/sender/{rawId}/recipient/{rawId}",
    "data": {
      "messageBody": "Welcome to Azure Communication Services",
      "messageId": "1613694358927",
      "metadata": {
        "key": "value",
        "description": "A map of data associated with the message"
      },
      "senderId": "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
      "senderCommunicationIdentifier": {
        "rawId": "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
        "communicationUser": {
          "id": "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724"
        }
      },
      "senderDisplayName": "Jhon",
      "composeTime": "2021-02-19T00:25:58.927Z",
      "type": "Text",
      "version": 1613694358927,
      "recipientId": "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d",
      "recipientCommunicationIdentifier": {
        "rawId": "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d",
        "communicationUser": {
          "id": "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d"
        }
      },
      "transactionId": "oh+LGB2dUUadMcTAdRWQxQ.1.1.1.1.1827536918.1.7",
      "threadId": "19:6e5d6ca1d75044a49a36a7965ec4a906@thread.v2"
    },
    "eventType": "Microsoft.Communication.ChatMessageReceived",
    "dataVersion": "1.0",
    "metadataVersion": "1",
    "eventTime": "2021-02-19T00:25:59.9436666Z"
  }
  ```
  ~~~

---
## Getting Started
To build the SDK for EventGrid, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the EventGrid API.

``` yaml
title: EventGridClient
description: EventGrid Client
openapi-type: data-plane
tag: package-2018-01
```

### Tag: package-2018-01

These settings apply only when `--tag=package-2018-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-01'
input-file:
- Microsoft.Storage/stable/2018-01-01/Storage.json
- Microsoft.EventHub/stable/2018-01-01/EventHub.json
- Microsoft.Resources/stable/2018-01-01/Resources.json
- Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
- Microsoft.Devices/stable/2018-01-01/IotHub.json
- Microsoft.ContainerRegistry/stable/2018-01-01/ContainerRegistry.json
- Microsoft.ServiceBus/stable/2018-01-01/ServiceBus.json
- Microsoft.Media/stable/2018-01-01/MediaServices.json
- Microsoft.Maps/stable/2018-01-01/Maps.json
- Microsoft.AppConfiguration/stable/2018-01-01/AppConfiguration.json
- Microsoft.SignalRService/stable/2018-01-01/SignalRService.json
- Microsoft.KeyVault/stable/2018-01-01/KeyVault.json
- Microsoft.MachineLearningServices/stable/2018-01-01/MachineLearningServices.json
- Microsoft.Cache/stable/2018-01-01/RedisCache.json
- Microsoft.Web/stable/2018-01-01/Web.json
- Microsoft.Communication/stable/2018-01-01/AzureCommunicationServices.json
- Microsoft.PolicyInsights/stable/2018-01-01/PolicyInsights.json
- Microsoft.ContainerService/stable/2018-01-01/ContainerService.json
```

### Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
    where: $.definitions.CloudEventEvent.properties.data_base64
    reason: This parameter name is defined by the Cloud Events 1.0 specification
```

---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_event_grid']
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.EventGrid
  sync-methods: None
  output-folder: $(csharp-sdks-folder)/eventgrid/Microsoft.Azure.EventGrid/src/Generated
  clear-output-folder: true
```


## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.eventgrid
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/eventgrid/data-plane
```

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Storage/stable/2018-01-01/Storage.json
  - $(this-folder)/Microsoft.EventHub/stable/2018-01-01/EventHub.json
  - $(this-folder)/Microsoft.Resources/stable/2018-01-01/Resources.json
  - $(this-folder)/Microsoft.EventGrid/stable/2018-01-01/EventGrid.json
  - $(this-folder)/Microsoft.Devices/stable/2018-01-01/IotHub.json
  - $(this-folder)/Microsoft.ContainerRegistry/stable/2018-01-01/ContainerRegistry.json
  - $(this-folder)/Microsoft.ServiceBus/stable/2018-01-01/ServiceBus.json
  - $(this-folder)/Microsoft.Media/stable/2018-01-01/MediaServices.json
  - $(this-folder)/Microsoft.Maps/stable/2018-01-01/Maps.json
  - $(this-folder)/Microsoft.AppConfiguration/stable/2018-01-01/AppConfiguration.json
  - $(this-folder)/Microsoft.SignalRService/stable/2018-01-01/SignalRService.json
  - $(this-folder)/Microsoft.KeyVault/stable/2018-01-01/KeyVault.json
  - $(this-folder)/Microsoft.MachineLearningServices/stable/2018-01-01/MachineLearningServices.json
  - $(this-folder)/Microsoft.Cache/stable/2018-01-01/RedisCache.json
  - $(this-folder)/Microsoft.Web/stable/2018-01-01/Web.json
  - $(this-folder)/Microsoft.Communication/stable/2018-01-01/AzureCommunicationServices.json
  - $(this-folder)/Microsoft.ContainerService/stable/2018-01-01/ContainerService.json

```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

