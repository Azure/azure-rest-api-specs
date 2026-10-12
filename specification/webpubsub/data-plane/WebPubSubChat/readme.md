# Azure Web PubSub Chat REST API

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Azure Web PubSub Chat REST API.

## Configuration

### Basic Information

These are the global settings for the Azure Web PubSub Chat REST API.

```yaml
openapi-type: data-plane
tag: package-2026-11-01
title: WebPubSubChatServiceClient
```

### Tag: package-2026-11-01

These settings apply only when `--tag=package-2026-11-01` is specified on the command line.

```yaml $(tag) == 'package-2026-11-01'
input-file:
  - stable/2026-11-01/webpubsubchat.json
```

### Tag: package-2026-02-01-preview

These settings apply only when `--tag=package-2026-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01-preview'
input-file:
  - preview/2026-02-01-preview/webpubsubchat.json
```
