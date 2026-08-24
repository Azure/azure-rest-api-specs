# DevCompute Data Plane API

> see https://aka.ms/autorest

This is the AutoRest configuration file for the DevCompute Data Plane API.

## Configuration

### Basic Information

```yaml
openapi-type: data-plane
tag: package-2026-09-01
suppressions:
  - code: LroExtension
    from: devcompute.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/stop/async"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots/{id}"].delete
    reason: These operations use non-standard accepted responses without an LRO polling header or a standard polling endpoint.
```

### Tag: package-2026-09-01

These settings apply only when `--tag=package-2026-09-01` is specified on the command line.

```yaml $(tag) == 'package-2026-09-01'
input-file:
  - stable/2026-09-01/devcompute.json
```

### Tag: package-2026-08-01-preview

These settings apply only when `--tag=package-2026-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-08-01-preview'
input-file:
  - preview/2026-08-01-preview/devcompute.json
```