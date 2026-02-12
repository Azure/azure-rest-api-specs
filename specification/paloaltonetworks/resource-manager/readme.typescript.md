## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-paloaltonetworksngfw"
  output-folder: "$(typescript-sdks-folder)/sdk/paloaltonetworksngfw/arm-paloaltonetworksngfw"
  payload-flattening-threshold: 1
  generate-metadata: true

directive:
  - from: PaloAltoNetworks.Cloudngfw.json
    where: $.paths
    transform: >
      for (const pathKey in $) {
        const path = $[pathKey];
        for (const methodKey in path) {
          const method = path[methodKey];
          if (method['x-ms-pageable'] && (method['x-ms-pageable']['operationName'] === 'LocalRulestacks_listAppIds' || method['x-ms-pageable']['operationName'] === 'LocalRulestacks_listCountries' || method['x-ms-pageable']['operationName'] === 'LocalRulestacks_listPredefinedUrlCategories')) {
            delete method['x-ms-pageable'];
          }
        }
      }
  - from: PaloAltoNetworks.Cloudngfw.json
    where-operation: GlobalRulestack_commit
    transform: > 
      $.responses["202"] = 
        {
          "description": "The request has been received but not yet acted upon."
        }
  - from: PaloAltoNetworks.Cloudngfw.json
    where-operation: LocalRulestacks_commit
    transform: >
      $.responses["202"] = 
        {  
          "description": "The request has been received but not yet acted upon."
        }
      
```
