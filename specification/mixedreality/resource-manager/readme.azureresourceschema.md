## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.MixedReality/stable/2020-05-01/proxy.json
  - Microsoft.MixedReality/stable/2020-05-01/spatial-anchors.json
  - Microsoft.MixedReality/preview/2020-04-06-preview/remote-rendering.json
  - Microsoft.MixedReality/preview/2020-04-06-preview/proxy.json
  - Microsoft.MixedReality/preview/2019-12-02-preview/proxy.json
  - Microsoft.MixedReality/preview/2019-12-02-preview/remote-rendering.json
  - Microsoft.MixedReality/preview/2019-12-02-preview/spatial-anchors.json
  - Microsoft.MixedReality/preview/2019-02-28-preview/mixedreality.json

```