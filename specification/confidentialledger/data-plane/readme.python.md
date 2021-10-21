## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

```yaml !$(track2)
python:
  clear-output-folder: true
  license-header: MICROSOFT_MIT_NO_VERSION
  no-namespace-folders: true
  package-version: "0.1"
```

```yaml $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
no-namespace-folders: true
package-name: azure-confidentialledger
package-version: "0.1"
payload-flattening-threshold: 2
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(multiapi) && !$(track2)
batch:
  - tag: package-0.1-preview-ledger
  - tag: package-0.1-preview-identity
```

```yaml $(multiapi) && $(track2)
clear-output-folder: true
batch:
  - tag: package-0.1-preview-ledger
  - multiapiscriptledger: true
  - tag: package-0.1-preview-identity
  - multiapiscriptidentity: true
```

### Multi-api script

```yaml $(multiapiscriptidentity)
multiapiscript: true
output-folder: $(python-sdks-folder)/confidentialledger/azure-confidentialledger/azure/confidentialledger/_generated/_generated_identity
clear-output-folder: false
keep-version-file: true
perform-load: false
```

```yaml $(multiapiscriptledger)
multiapiscript: true
output-folder: $(python-sdks-folder)/confidentialledger/azure-confidentialledger/azure/confidentialledger/_generated/_generated_ledger
clear-output-folder: false
keep-version-file: true
perform-load: false
```

### Tag: package-0.1-preview-identity and python

These settings apply only when `--tag=package-0.1-preview-identity --python` is specified on the command line.
```yaml $(tag) == 'package-0.1-preview-identity'
namespace: azure.confidentialledger._generated/_generated_identity.v0_1_preview
output-folder: $(python-sdks-folder)/confidentialledger/azure-confidentialledger/azure/confidentialledger/_generated/_generated_identity/v0_1_preview
```

### Tag: package-0.1-preview-ledger and python

These settings apply only when `--tag=package-0.1-preview-ledger --python` is specified on the command line.
```yaml $(tag) == 'package-0.1-preview-ledger'
namespace: azure.confidentialledger._generated/_generated_ledger.v0_1_preview
output-folder: $(python-sdks-folder)/confidentialledger/azure-confidentialledger/azure/confidentialledger/_generated/_generated_ledger/v0_1_preview
```
