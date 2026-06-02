# Suppression Test - Security Rule

> see https://aka.ms/autorest

```yaml
openapi-type: arm
tag: package-2025-01-01
```

### Tag: package-2025-01-01

These settings apply only when `--tag=package-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01-01'
input-file:
  - Microsoft.SecretVault/stable/2025-01-01/secretvault.json
directive:
  - suppress: XmsSecretNotReadBack
    reason: "existing pattern"
    where: $.definitions.VaultProperties.properties.connectionString
  - suppress: SecretPropertyMustBeWriteOnly
    reason: "will fix later"
    where: $.definitions.VaultProperties.properties.adminPassword
```
