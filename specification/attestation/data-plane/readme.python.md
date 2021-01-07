## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: update
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
namespace: azure.security.attestation
add-credential: true
credential-scopes: https://attest.azure.net/.default
package-name: azure-security-attestation
package-version: 1.0.0b1
clear_output_folder: true
no-namespace-folders: true
```

``` yaml $(python) && $(track2)
tag: package-2020-10-01
v3: true
output-folder: $(python-sdks-folder)/attestation/azure-security-attestation/azure/security/attestation
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
```
