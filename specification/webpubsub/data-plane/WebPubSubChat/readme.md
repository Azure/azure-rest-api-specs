# Azure Web PubSub Chat REST API

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Azure Web PubSub Chat REST API.

## Python SDK customization

`client.tsp` defines lifecycle-specific Python request models while retaining the
original resource models for responses. Create models omit service-assigned
fields; PATCH models have optional updateable fields. The user request models
retain the `kind` discriminator and human-user subtype.

`python-customizations.mjs` resolves the `resource` body parameter from each
instantiated standard operation and applies the client generator core's
`alternateType` decorator with the `python` scope. This avoids changing the
standard resource operations, REST contract, and other language SDKs. Keep this
module alongside `client.tsp` when generating from local inputs.

## Configuration

### Basic Information

These are the global settings for the Azure Web PubSub Chat REST API.

```yaml
openapi-type: data-plane
tag: package-2026-08-01-preview
title: WebPubSubChatServiceClient
```

### Tag: package-2026-08-01-preview

These settings apply only when `--tag=package-2026-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-08-01-preview'
input-file:
  - preview/2026-08-01-preview/webpubsubchat.json
```

### Tag: package-2026-02-01-preview

These settings apply only when `--tag=package-2026-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01-preview'
input-file:
  - preview/2026-02-01-preview/webpubsubchat.json
```
