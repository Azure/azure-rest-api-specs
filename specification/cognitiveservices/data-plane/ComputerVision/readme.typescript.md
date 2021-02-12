## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
directive:
  from: source-file-nodejs
  where: $
  transform: >
    $ = $.replace( /mode: string, url: string/g, "url: string, mode: string" );
    $ = $.replace( /mode, url/g, "url, mode" );
typescript:
  package-name: "@azure/cognitiveservices-computervision"
  output-folder: "$(typescript-sdks-folder)/sdk/cognitiveservices/cognitiveservices-computervision"
  azure-arm: false
  generate-metadata: true
```
