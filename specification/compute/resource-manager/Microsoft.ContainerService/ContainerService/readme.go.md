## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum and then remove it from the generated code to avoid the generator generates the code by hard-coding the single-entry enum value
    # this directive adds a DummyOrchestrationServiceName to the enum type
  - from: virtualMachineScaleSet.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

    # this directive removes the DummyOrchestrationServiceName from the generated code, so that we still have only one enum entry in this enum type.
  - from: source-file-go
    where: $ 
    transform: >-
      return $.
        replace(/\/\/ (OrchestrationServiceNames)?DummyOrchestrationServiceName .../g,'').
        replace(/(OrchestrationServiceNames)?DummyOrchestrationServiceName OrchestrationServiceNames = "DummyOrchestrationServiceName"\n/g,'').
        replace(/,(OrchestrationServiceNames)?DummyOrchestrationServiceName/,'').
        replace(/, '(OrchestrationServiceNames)?DummyOrchestrationServiceName'/,'');
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/compute/armcompute
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true

directive:
  # we do not need to hack to add a dummy enum entry in track 2, because track 2 generator will generate the enum type even if it only has on entry 
  - from: diskRPCommon.json
    where: "$.definitions.PurchasePlan"
    transform: >
      $["x-ms-client-name"] = "DiskPurchasePlan";
  - from: ComputeRP.json
    where: $.definitions
    transform: delete $["Expand"]
    reason: https://github.com/Azure/typespec-azure/issues/2499
  - from: ComputeRP.json            
    where: $.definitions.VirtualMachineScaleSetVMExtension.properties.name
    transform: delete $["x-ms-client-name"]
    reason: https://github.com/Azure/typespec-azure/issues/2517
  - from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetExtension.properties.name
    transform: delete $["x-ms-client-name"]
    reason: https://github.com/Azure/typespec-azure/issues/2517
  - from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetStorageProfile.properties.diskControllerType
    transform: >
      delete $["$ref"];
      $["type"] = "string";
  - from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetUpdateStorageProfile.properties.diskControllerType
    transform: >
      delete $["$ref"];
      $["type"] = "string";
  - from: swagger-document
    where: "$.definitions.Operation"
    transform: >
      $["x-ms-client-name"] = "OperationValue";
```
