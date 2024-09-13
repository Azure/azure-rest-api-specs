## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

## Common TypeScript settings

``` yaml $(typescript)
typescript:
  azure-arm: true
  generate-metadata: true

modelerfour:
  treat-type-object-as-anything: true

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: virtualMachineScaleSet.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

  - from: source-file-typescript
    where: $ 
    transform: >-
      return $.
        replace(/[,|*] 'DummyOrchestrationServiceName'/g,'');

  # we do not need to hack to add a dummy enum entry in track 2, because track 2 generator will generate the enum type even if it only has on entry 
  - from: diskRPCommon.json
    where: "$.definitions.PurchasePlan"
    transform: >
      $["x-ms-client-name"] = "DiskPurchasePlan";
```

``` yaml $(typescript) && !$(profile-content)
  package-name: "@azure/arm-compute"
  output-folder: "$(typescript-sdks-folder)/sdk/compute/arm-compute"
  
```

### Profile: profile-hybrid-2019-03-01

These settings apply only when `--profile-content=profile-hybrid-2019-03-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2019-03-01'
typescript:
  package-name: "@azure/arm-compute-profile-2019-03-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/compute/arm-compute-profile-2019-03-01-hybrid"
  batch:
    - tag: profile-hybrid-2019-03-01
```

### Profile: profile-hybrid-2020-09-01

These settings apply only when `--profile-content=profile-hybrid-2020-09-01` is specified on the command line.

``` yaml $(profile-content)=='profile-hybrid-2020-09-01'
typescript:
  package-name: "@azure/arm-compute-profile-2020-09-01-hybrid"
  output-folder: "$(typescript-sdks-folder)/sdk/compute/arm-compute-profile-2020-09-01-hybrid"
  azure-arm: true
  generate-metadata: true
  batch:
    - tag: profile-hybrid-2020-09-01
```
