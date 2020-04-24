## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_cognitiveservices_translation_batch
package-version: "0.0.1"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: release_1_0_preview
```

### Tag: release_1_0_preview and ruby

These settings apply only when `--tag=release_1_0_preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_1_0_preview' && $(ruby)
namespace: "Azure::CognitiveServices::Translation::Batch::V1_0"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_translation_batch/lib
title: "TranslationBatchClient"
```
