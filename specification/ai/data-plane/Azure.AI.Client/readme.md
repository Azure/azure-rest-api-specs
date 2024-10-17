# Azure AI Client SDK

> see https://aka.ms/autorest

Configuration for Azure AI Client SDK.

The current release is `2024-07-01-preview`.

``` yaml
tag: 2024-07-01-preview
add-credentials: true
openapi-type: data-plane
```

# Releases

### Release 2024-07-01-preview
These settings apply only when `--tag=2024-07-01-preview` is specified on the command line.
``` yaml $(tag) == '2024-07-01-preview'
input-file:
  - preview/2024-07-01-preview/azure-ai-client.json
suppressions:
  - code: AvoidAnonymousParameter
    from: azure-ai-client.json
    reason: Anonymous parameters were not used. This error makes no sense.
```
