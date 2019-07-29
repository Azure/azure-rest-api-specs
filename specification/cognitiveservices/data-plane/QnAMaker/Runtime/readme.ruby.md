## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_cognitiveservices_qnamaker_runtime
package-version: "0.17.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: runtime_release_5_0
```

### Tag: runtime_release_5_0 and ruby

These settings apply only when `--tag=runtime_release_5_0 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'runtime_release_5_0' && $(ruby)
namespace: "Azure::CognitiveServices::Qnamaker::V5_0"
output-folder: $(ruby-sdks-folder)/data/azure_cognitiveservices_qnamaker_runtime/lib
```