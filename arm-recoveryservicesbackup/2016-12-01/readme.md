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
  - ./swagger/backupManagement.json
azure-arm: true
```

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Autorest invalidates two letter acronyms as well and changes in data contracts require service wide changes and require more time
```

## Code Generation

### C#

```yaml
csharp:
  namespace: Microsoft.Azure.Management.RecoveryServices.Backup
  output-folder: Generated/CSharp
```

### Python

```yaml
python:
  namespace: azure.mgmt.recoveryservices.backup
  package-name: azure-mgmt-recoveryservicesbackup
  package-version: 1.0.0-preview
  output-folder: Generated/Python
```