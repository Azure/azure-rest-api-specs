## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_cognitiveservices_computervision
package-version: "0.16.0"
azure-arm: true

directive:
  from: source-file-ruby
  where: $
  transform: >
    $ = $.replace( /mode, url/g, "url, mode" );
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: release_2_0
```

### Tag: release_2_0 and ruby

These settings apply only when `--tag=release_2_0 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_2_0' && $(ruby)
namespace: "Azure::CognitiveServices::ComputerVision::V2_0"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_computervision/lib
title: "ComputerVisionClient"
```
