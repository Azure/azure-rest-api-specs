### Ruby multi-api for links

``` yaml $(multiapi) && $(links)
package-name: azure_mgmt_links
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-links-2016-09
```

### Tag: package-links-2016-09 and ruby

These settings apply only when `--tag=package-links-2016-09 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-links-2016-09' && $(ruby)
namespace: "Azure::Links::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_links/lib
```
