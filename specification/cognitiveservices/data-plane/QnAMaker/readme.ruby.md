## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_cognitiveservices_qnamaker
package-version: "1.0.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: release_4_0
  - tag: release_5_0_preview.1
```

### Tag: release_4_0 and ruby

These settings apply only when `--tag=release_4_0 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_4_0' && $(ruby)
namespace: "Azure::CognitiveServices::Qnamaker::V4_0"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_qnamaker/lib
```


### Tag: release_5_0_preview.1 and ruby

These settings apply only when `--tag=release_5_0_preview.1 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_5_0_preview.1' && $(ruby)
namespace: "Azure::CognitiveServices::Qnamaker::V5_0_preview_1"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_qnamaker/lib/preview/v5.0-preview.1
```