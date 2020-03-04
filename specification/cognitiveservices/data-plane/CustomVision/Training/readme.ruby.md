## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_cognitiveservices_customvision_training
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: release_1_0
  - tag: release_3_0
  - tag: release_3_1
  - tag: release_3_2
```

### Tag: release_1_0 and ruby

These settings apply only when `--tag=release_1_0 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_1_0' && $(ruby)
namespace: "Azure::CognitiveServices::CustomVision::Training::V1_0"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_customvisiontraining/lib
title: "TrainingClient"
```

### Tag: release_3_0 and ruby

These settings apply only when `--tag=release_3_0 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_3_0' && $(ruby)
namespace: "Azure::CognitiveServices::CustomVision::Training::V3_0"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_customvisiontraining/lib
title: "TrainingClient"
```

### Tag: release_3_1 and ruby

These settings apply only when `--tag=release_3_1 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_3_1' && $(ruby)
namespace: "Azure::CognitiveServices::CustomVision::Training::V3_1"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_customvisiontraining/lib
title: "TrainingClient"
```

### Tag: release_3_2 and ruby

These settings apply only when `--tag=release_3_2 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'release_3_2' && $(ruby)
namespace: "Azure::CognitiveServices::CustomVision::Training::V3_2"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_customvisiontraining/lib
title: "TrainingClient"
```

