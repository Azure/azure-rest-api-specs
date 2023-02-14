# Defender EASM SDK

> see https://aka.ms/autorest

Configuration for generating EASM SDK.

The current release is `2022-04-01-preview`.

``` yaml

tag: 2022-04-01-preview
add-credentials: true
openapi-type: data-plane
openapi-subtype: providerHub
license-header: MICROSOFT_MIT_NO_CODEGEN
```
# Releases

### Release 2022-04-01-preview
These settings apply only when `--tag=2022-04-01-preview` is specified on the command line.

``` yaml $(tag) == '2022-04-01-preview'
input-file:
  - Microsoft.Easm/preview/2022-04-01-preview/easm.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp)
csharp:
  sync-methods: None
  azure-arm: false
  namespace: Azure.Security.Easm
  output-folder: $(csharp-sdks-folder)/Security/Easm/src/Generated
  clear-output-folder: true
```

## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.
May need to supply `--version=V2` on the command line.

``` yaml $(python)
python-mode: create
add-credentials: true
payload-flattening-threshold: 2
namespace: azure.security.easm
package-name: azure-security-easm
package-version: 0.9.0
clear-output-folder: true
use: "@microsoft.azure/autorest.python@~4.0.71"
version: V2
multiapi: true
no-async: true
client-side-validation: false
```
``` yaml $(python) && $(python-mode) == 'update'
no-namespace-folders: true
output-folder: $(python-sdks-folder)/security/azure-security-easm/azure/security/easm
```
``` yaml $(python) && $(python-mode) == 'create'
basic-setup-py: true
output-folder: $(python-sdks-folder)/security/azure-security-easm
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  namespace: azure.security.easm
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/security/data-plane/easm
  with-optional-parameters: true
  with-single-async-method: true
  with-default-group-name: Easm
```
