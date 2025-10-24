# Defender EASM SDK

> see https://aka.ms/autorest

Configuration for generating EASM SDK.

The current release is `2024-10-01-preview`.

```yaml
tag: 2024-10-01-preview
add-credentials: true
openapi-type: data-plane
openapi-subtype: providerHub
license-header: MICROSOFT_MIT_NO_CODEGEN
azure-arm: true
clear-output-folder: true
```

# Releases

### Release 2022-04-01-preview

These settings apply only when `--tag=2022-04-01-preview` is specified on the command line.

```yaml $(tag) == '2022-04-01-preview'
input-file:
  - Microsoft.Easm/preview/2022-04-01-preview/easm.json
```

### Release 2022-09-01-preview

These settings apply only when `--tag=2022-09-01-preview` is specified on the command line.

```yaml $(tag) == '2022-09-01-preview'
input-file:
  - Microsoft.Easm/preview/2022-09-01-preview/easm.json
```

### Release 2022-11-01-preview

These settings apply only when `--tag=2022-11-01-preview` is specified on the command line.

```yaml $(tag) == '2022-11-01-preview'
input-file:
  - Microsoft.Easm/preview/2022-11-01-preview/easm.json
```

### Release 2023-03-01-preview

These settings apply only when `--tag=2023-03-01-preview` is specified on the command line.

```yaml $(tag) == '2023-03-01-preview'
input-file:
  - Microsoft.Easm/preview/2023-03-01-preview/easm.json
```

### Release 2024-03-01-preview

These settings apply only when `--tag=2024-03-01-preview` is specified on the command line.

```yaml $(tag) == '2024-03-01-preview'
input-file:
  - Microsoft.Easm/preview/2024-03-01-preview/easm.json
```

### Release 2024-10-01-preview

These settings apply only when `--tag=2024-10-01-preview` is specified on the command line.

```yaml $(tag) == '2024-10-01-preview'
input-file:
  - Microsoft.Easm/preview/2024-10-01-preview/easm.json
```

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.
May need to supply `--version=V2` on the command line.

```yaml $(python)
python-mode: create
add-credentials: true
payload-flattening-threshold: 2
namespace: azure.defender.easm
package-name: azure-defender-easm
package-version: 0.9.0
use: "@microsoft.azure/autorest.python@~4.0.71"
version: V2
multiapi: true
no-async: true
client-side-validation: false
```

```yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/defender/azure-defender-easm/azure/defender/easm
```

```yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/defender/azure-defender-easm
```

### Suppress non-TypeSpec SDK related linting rules

These set of linting rules aren't applicable to the new TypeSpec SDK code generators so suppressing them here. Eventually we will
opt-out these rules from running in the linting tools for TypeSpec generated swagger files.

```yaml
suppressions:
  - code: AvoidAnonymousTypes
  - code: PatchInOperationName
  - code: OperationIdNounVerb
  - code: RequiredReadOnlyProperties
  - code: SchemaNamesConvention
  - code: SchemaDescriptionOrTitle
```
