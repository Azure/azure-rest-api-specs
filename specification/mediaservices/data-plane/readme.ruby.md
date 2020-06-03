## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_media_edge_lva_client
package-version: "1.0.0"
azure-arm: true

```

### Tag: package-lva-1-0-0-preview and ruby

These settings apply only when `--tag=package-lva-1-0-0-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-lva-1-0-0-preview' && $(ruby)
namespace: "Azure::MediaServices::Edge::LVA::Client::V1_0_0"
output-folder: $(ruby-sdks-folder)/management/azure_media_edge_lva_client/lib
```