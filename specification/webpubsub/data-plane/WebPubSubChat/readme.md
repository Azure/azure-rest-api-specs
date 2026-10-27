# Azure Web PubSub Chat REST API

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Azure Web PubSub Chat REST API.

## Python and JavaScript SDK customization

`client.tsp` defines lifecycle-specific request models while retaining the
original resource models for responses. Create models omit service-assigned
fields; PATCH models have optional updateable fields. The user request models
retain the `kind` discriminator and human-user subtype.

PUT models use `CreateOrUpdate` projections. Topic PUT requires `title` and
optionally accepts `state` when replacing an existing topic. PATCH projections
use `OptionalProperties<Update<...>>` so unchanged fields can be omitted.
JavaScript uses the same projections and `CreateOrReplace` / `Update` model
names as Python, with a concrete `HumanChatUserCreateOrReplace` requiring
`kind: "Human"`, `nickname`, and `roleName`.

`python-customizations.mjs` resolves the `resource` body parameter from each
instantiated standard operation and applies the client generator core's
`alternateType` decorator with an explicit language scope (defaulting to Python).
JavaScript bindings opt in explicitly; experimental visibility splitting is not
enabled. This avoids changing the
standard resource operations, REST contract, and other language SDKs. Keep this
module alongside `client.tsp` when generating from local inputs.

For Python listing operations, `omitContinuationToken` resolves the instantiated
`continuationToken` parameter and applies the standard client generator core
`scope("!python")` decorator. Python callers use `by_page(continuation_token=...)`
on the returned pager to resume from a previous page. The service query parameter,
next-link pagination, and other language SDKs are unchanged.

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
