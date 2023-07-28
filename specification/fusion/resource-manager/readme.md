# fusion

> see https://aka.ms/autorest

## Configuration

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: 2023-02-01-preview
```

### Supported API Versions


```yaml $(tag) == '2019-09-01-preview'
input-file:
  - Wandisco.Fusion/preview/2019-09-01-preview/fusionGroups.json
```

```yaml $(tag) == '2020-12-01-preview'
input-file:
  - Wandisco.Fusion/preview/2020-12-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-01-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-01-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-02-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-02-01-preview/fusionGroups.json
```

```yaml $(tag) == '2021-05-01-preview'
input-file:
  - Wandisco.Fusion/preview/2021-05-01-preview/fusionGroups.json
  - Wandisco.Fusion/preview/2021-05-01-preview/migrators.json
  - Wandisco.Fusion/preview/2021-05-01-preview/operations.json
  - Wandisco.Fusion/preview/2021-05-01-preview/commonTypes.json
```

```yaml $(tag) == '2022-01-01-preview'
input-file:
  - Wandisco.Fusion/preview/2022-01-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2022-01-01-preview/migrators.json
  - Wandisco.Fusion/preview/2022-01-01-preview/operations.json
```

```yaml $(tag) == '2022-10-01-preview'
input-file:
  - Wandisco.Fusion/preview/2022-10-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2022-10-01-preview/migrators.json
  - Wandisco.Fusion/preview/2022-10-01-preview/operations.json
```

```yaml $(tag) == '2023-02-01-preview'
input-file:
  - Wandisco.Fusion/preview/2023-02-01-preview/commonTypes.json
  - Wandisco.Fusion/preview/2023-02-01-preview/migrators.json
  - Wandisco.Fusion/preview/2023-02-01-preview/operations.json
```

### Supressions

``` yaml
suppressions:
  - code: RPaas_ResourceProvisioningState
    where: $.definitions.OperationStatus
    reason: Existing rpaas service blocked by new validation rule - OperationStatus identified as Azure Resource in error
  - code: ResourceNameRestriction
    from: migrators.json
    where: 
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Wandisco.Fusion/migrators/{migratorName}/liveDataMigrations/{migrationName}/reset"]
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Wandisco.Fusion/migrators/{migratorName}/verifications"]
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Wandisco.Fusion/migrators/{migratorName}/verifications/{verificationName}"]
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Wandisco.Fusion/migrators/{migratorName}/verifications/{verificationName}/cancel"]
    reason: Existing rpaas service blocked by new validation rule - existing resources will be affected by new validation
  - code: PathContainsResourceType
    from: migrators.json
    where:
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Wandisco.Fusion/migrators/{migratorName}/verifications"]
    - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Wandisco.Fusion/migrators/{migratorName}/verifications/{verificationName}"]
    reason: Have to register API before registering RT, RT depends on this API version
```

## Language specific configurations

### python

```yaml $(python)
no-namespace-folders: true
azure-arm: true
clear-output-folder: true
```

### java
```yaml $(java)
azure-arm: true
namespace: com.wandisco.frp.api.client
```
