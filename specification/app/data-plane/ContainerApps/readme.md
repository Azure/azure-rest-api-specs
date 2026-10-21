# Azure Container Apps Sandbox

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Azure Container Apps Sandbox data plane API.

## Configuration

### Basic Information

```yaml
openapi-type: data-plane
tag: package-2026-10-01-preview
```

### Tag: package-2026-10-01-preview

These settings apply only when `--tag=package-2026-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/containerappssandbox.json
```

### Tag: package-2026-09-01-preview

These settings apply only when `--tag=package-2026-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-09-01-preview'
input-file:
  - preview/2026-09-01-preview/containerappssandbox.json
```

## Secrets in 2026-10-01-preview

Secret values support inline objects (`{ "value": "example" }`) and Key Vault references
(`{ "secretName": "example", "secretVersion": "optional-version" }`). Each entry must contain
exactly one of `value` or `secretName`. The service also accepts plain strings as inline-value
shorthand for compatibility. Swagger 2.0 cannot express a string-or-object union, so the
new specification models the object form for strongly typed clients.

The `values` dictionary must not be empty. If any entry references Key Vault, supply a
shared `valueReferenceSource` with `keyVaultUrl`, optional `vnetConnectionName`, and
`authentication.identity`. Its `type` must be `SystemAssigned` or `UserAssigned`.
For `UserAssigned`, `identityResourceId` must identify an attached user-assigned managed
identity; for `SystemAssigned`, it must be absent. Inline-only secrets must not include
`valueReferenceSource`. A secret may contain at most 80 Key Vault references, and each
Key Vault secret name may occur only once, ignoring case.

Peek now returns value-definition objects, including `secretActualVersion` for resolved
Key Vault references, rather than returning resolved reference values. Secret resources
may include a `resolution` result with `Succeeded` or `Failed`, the last attempt timestamp,
and error details. Listing supports `pageSize` from 1 to 100 (default 25); an explicit
size used with `skipToken` must match the size encoded in that token.

The `2026-09-01-preview` specification retains its string-valued secret contract.
