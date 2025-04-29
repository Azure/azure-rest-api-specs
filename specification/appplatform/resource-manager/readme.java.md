## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
directive:
  - from: appplatform.json
    where: $.definitions.AppResourceProperties.properties.addonConfigs
    transform: >
      $['additionalProperties'] = 
        {
          "type": "object",
          "additionalProperties": {
            "type": "object"
          }
        }
    reason: server backend response is still double-map structure
  - from: appplatform.json
    where: $.definitions.DeploymentSettings.properties.addonConfigs
    transform: >
      $['additionalProperties'] = 
        {
          "type": "object",
          "additionalProperties": {
            "type": "object"
          }
        }
    reason: server backend response is still double-map structure
  - from: appplatform.json
    where: $.definitions.BindingResourceProperties.properties.bindingParameters.additionalProperties
    transform: >
      $['type'] = "object"
    reason: avoid breaking change
```