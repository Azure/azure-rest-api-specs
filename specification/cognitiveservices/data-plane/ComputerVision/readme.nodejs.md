## Node.js

These settings apply only when `--nodejs` is specified on the command line.
Please also specify `--node-sdks-folder=<path to root folder of your azure-sdk-for-node clone>`.

``` yaml $(nodejs)
nodejs:
  package-name: azure-cognitiveservices-computervision
  output-folder: $(node-sdks-folder)/lib/services/computerVision
  azure-arm: false
  generate-license-txt: true
  generate-package-json: true
  generate-readme-md: false

directive:
  from: source-file-nodejs
  where: $
  transform: >
    $ = $.replace( /mode: string, url: string/g, "url: string, mode: string" );
    $ = $.replace( /mode, url/g, "url, mode" );
```
