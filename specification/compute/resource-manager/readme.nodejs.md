## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  azure-arm: true
  package-name: azure-arm-compute
  output-folder: $(node-sdks-folder)/lib/services/computeManagement2
  payload-flattening-threshold: 1
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false

directive:
    # dynamically add a DummyOrchestrationServiceName value to the enum 
  - from: compute.json
    where: $..enum
    transform: >-
      if( $.length === 1 && $[0] === "AutomaticRepairs") { 
        $.push('DummyOrchestrationServiceName');
      }
      return $;

  - from: source-file-nodejs
    where: $ 
    transform: >-
      return $.
        replace(/[,*] 'DummyOrchestrationServiceName'/g,'');
```
