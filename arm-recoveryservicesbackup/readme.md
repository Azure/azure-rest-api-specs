# Scenario: RecoveryServices.Backup swagger configuration

> see https://aka.ms/autorest

## Information
```yaml
override-info:
  title: Recovery Services Backup Client
  description: Open API 2.0 Specs for Azure RecoveryServices Backup service
```

## Inputs

``` yaml 
input-file:
  - ./2016-12-01/swagger/backupManagement.json
  - ./2016-08-10/swagger/operations.json
azure-arm: true
license-header: MICROSOFT_MIT
```

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Autorest invalidates two letter acronyms as well and changes in data contracts require service wide changes and require more time
```

## Code Generation

### C#

```yaml $(csharp)
csharp:
  namespace: Microsoft.Azure.Management.RecoveryServices.Backup
  output-folder: $(output-folder)Generated/CSharp
```

### Python

```yaml $(python)
python:
  namespace: azure.mgmt.recoveryservicesbackup
  package-version: 0.1.0
  output-folder: $(output-folder)Generated/Python
  payload-flattening-threshold: 2
  license-header: MICROSOFT_MIT_NO_VERSION
```

```yaml $(python) && $(create)
python:
  package-name: azure-mgmt-recoveryservicesbackup
```