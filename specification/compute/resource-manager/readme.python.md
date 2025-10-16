## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(python)
title: ComputeManagementClient
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-compute
namespace: azure.mgmt.compute
package-version: 1.0.0b1
clear-output-folder: true
modelerfour:
  lenient-model-deduplication: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: virtualMachineScaleSet.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

  - from: source-file-python
    where: $ 
    transform: >-
      return $.
        replace(/, 'DummyOrchestrationServiceName'/g,'').
        replace(/dummy_orchestration_service_name = "DummyOrchestrationServiceName"/g,'');
```

``` yaml $(python)
no-namespace-folders: true
output-folder: $(python-sdks-folder)/compute/azure-mgmt-compute/azure/mgmt/compute
```
