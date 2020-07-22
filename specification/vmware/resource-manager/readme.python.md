## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

```yaml $(python)
python-mode: create
<<<<<<< HEAD

python:
  package-version: 0.1.0
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  override-client-name: AVSClient
  namespace: azure.mgmt.avs
  package-name: azure-mgmt-avs
=======
python:
  package-version: 0.3.0
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.vmware
  package-name: azure-mgmt-vmware
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
<<<<<<< HEAD
  output-folder: $(python-sdks-folder)/compute/azure-mgmt-avs/azure/mgmt/avs
=======
  output-folder: $(python-sdks-folder)/compute/azure-mgmt-vmware/azure/mgmt/vmware
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
<<<<<<< HEAD
  output-folder: $(python-sdks-folder)/compute/azure-mgmt-avs
```
=======
  output-folder: $(python-sdks-folder)/compute/azure-mgmt-vmware
```
>>>>>>> 4ea1e0abb0265a95f3f49494d2f0815b6be6d7d6
