## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-nginx"
  output-folder: "$(typescript-sdks-folder)/sdk/nginx/arm-nginx"
  generate-metadata: true

directive: 
  - from: swagger-document
    where-operation: Certificates_Delete
    transform: >
      $.responses["202"] = 
        {  
          "description": "Success"
        }
  - from: swagger-document
    where-operation: Configurations_Delete
    transform: >
      $.responses["202"] = 
        {  
          "description": "Success"
        }
  - from: swagger-document
    where-operation: Deployments_Delete
    transform: >
      $.responses["202"] = 
        {  
          "description": "Success"
        }
```
