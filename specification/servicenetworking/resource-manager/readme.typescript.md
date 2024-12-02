## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-servicenetworking"
  output-folder: "$(typescript-sdks-folder)/sdk/servicenetworking/arm-servicenetworking"
  generate-metadata: true
title: ServiceNetworkingManagementClient 
modelerfour:
  flatten-models: false
directive:
  - from : TrafficController.json
    where: $.definitions
    transform : >
      $.SecurityPolicyProperties = {
        "type": "object",
        "description": "SecurityPolicy Properties.",
        "properties": {
          "policyType": {
            "$ref": "#/definitions/PolicyType",
            "description": "Type of the Traffic Controller Security Policy",
            "readOnly": true
          },
          "wafPolicy": {
            "$ref": "#/definitions/WafPolicy",
            "description": "Web Application Firewall Policy of the Traffic Controller Security Policy"
          },
          "provisioningState": {
            "$ref": "#/definitions/ProvisioningState",
            "description": "Provisioning State of Traffic Controller SecurityPolicy Resource",
            "readOnly": true
          }
        },
      }
      
```
