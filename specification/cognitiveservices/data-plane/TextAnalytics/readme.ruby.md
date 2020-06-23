## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_cognitiveservices_textanalytics
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: release_2_1
```

### Tag: release_2_1 and ruby

These settings apply only when `--tag=release_2_1 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_2_1' && $(ruby)
namespace: "Azure::CognitiveServices::TextAnalytics::V2_1"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_textanalytics/lib
title: "TextAnalyticsClient"
```
