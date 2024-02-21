## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "@azure/arm-apicenter"
  output-folder: "$(typescript-sdks-folder)/sdk/apicenter/arm-apicenter"
  payload-flattening-threshold: 1
  clear-output-folder: true
  generate-metadata: true

directive:
  - from: apicenter.json 
    where: '$.paths[*].put.parameters'
    transform: >
      for (const param of $) {
        if (param['name'] == 'payload') {
           delete param["x-ms-client-name"]
        }
      }
  - from: apicenter.json 
    where: '$.paths[*].post.parameters'
    transform: >
      for (const param of $) {
        if (param['name'] == 'payload') {
           delete param["x-ms-client-name"]
        }
      }
  - from: apicenter.json 
    where: '$.paths[*].patch.parameters'
    transform: >
      for (const param of $) {
        if (param['name'] == 'payload') {
           delete param["x-ms-client-name"]
        }
      }
```
