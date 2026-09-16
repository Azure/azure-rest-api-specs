# Microsoft.DeviceUpdate - DuDeviceRegistry

> see https://aka.ms/autorest

This is the AutoRest configuration file for the DeviceUpdate's DeviceRegistry linking service under Microsoft.DeviceUpdate.

## Configuration

### Basic Information

These are the global settings for the DuDeviceRegistry.

```yaml
openapi-type: arm
tag: package-2026-11-02-preview
# NOTE: No explicit `default` tag is set intentionally. The `tag` value above
# serves as the implicit default. A `default` tag will be introduced once a
# stable API version is published.
```

### Tag: package-2026-11-02-preview

These settings apply only when `--tag=package-2026-11-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-11-02-preview'
input-file:
  - preview/2026-11-02-preview/dudeviceupdate.json
```

### Tag: package-2026-07-02-preview

These settings apply only when `--tag=package-2026-07-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-07-02-preview'
input-file:
  - preview/2026-07-02-preview/dudeviceupdate.json
```

### Tag: package-2026-06-01-preview

These settings apply only when `--tag=package-2026-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-06-01-preview'
input-file:
  - preview/2026-06-01-preview/dudeviceupdate.json
suppressions:
  - code: INVALID_TYPE
    from: dudeviceupdate.json
    reason: LinkUpdateResponse is intentionally an empty object ({}) to make this response model extensible in the future without breaking changes. OAV incorrectly flags the example body as type mismatch.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/linkedAccounts/{linkedAccountName}/linkUpdate"].post.responses["200"]
  - code: AvoidAdditionalProperties
    from: dudeviceupdate.json
    reason: LinkUpdateResponse uses additionalProperties to represent an empty response object for forward extensibility. Will be removed when concrete properties are added.
    where: $.definitions.LinkUpdateResponse
```

### Tag: package-2026-05-01-preview

These settings apply only when `--tag=package-2026-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-05-01-preview'
input-file:
  - preview/2026-05-01-preview/dudeviceupdate.json
suppressions:
  - code: PostResponseCodes
    from: dudeviceupdate.json
    reason: Empty response model to satisfy R4008 AvoidEmptyResponseSchema, and preserves forward extensibility so future fields can be added without changing status code.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/linkedAccounts/{linkedAccountName}/linkUpdate"].post
  - code: INVALID_TYPE
    from: dudeviceupdate.json
    reason: LinkUpdateResponse is intentionally an empty object ({}) to make this response model extensible in the future without breaking changes. OAV incorrectly flags the example body as type mismatch.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceUpdate/linkedAccounts/{linkedAccountName}/linkUpdate"].post.responses["200"]
  - code: AvoidAdditionalProperties
    from: dudeviceupdate.json
    reason: LinkUpdateResponse uses additionalProperties to represent an empty response object for forward extensibility. Will be removed when concrete properties are added.
    where: $.definitions.LinkUpdateResponse
```
