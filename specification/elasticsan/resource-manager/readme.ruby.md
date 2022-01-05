## Ruby

These settings apply only when `--ruby` is specified on the command line.


### Tag: package-2021-11-20-preview and ruby

These settings apply only when `--tag=package-2021-11-20-preview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2021-11-20-preview' && $(ruby)
namespace: Microsoft.ElasticSan
output-folder: $(ruby-sdks-folder)/elasticsans
```
