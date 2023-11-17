## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
title: HDInsightContainersMgmtClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
namespace: azure.mgmt.hdinsightcontainers
package-name: azure-mgmt-hdinsightcontainers
package-version: 1.0.0b1
clear-output-folder: true
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/hdinsight/azure-mgmt-hdinsightcontainers/azure/mgmt/hdinsightcontainers
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
```
