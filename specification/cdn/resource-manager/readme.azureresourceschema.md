## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Cdn/stable/2020-04-15/cdn.json
  - Microsoft.Cdn/stable/2020-04-15/cdnwebapplicationfirewall.json
  - Microsoft.Cdn/stable/2019-12-31/cdn.json
  - Microsoft.Cdn/stable/2019-06-15/cdn.json
  - Microsoft.Cdn/stable/2019-06-15/cdnwebapplicationfirewall.json
  - Microsoft.Cdn/preview/2019-06-15-preview/cdn.json
  - Microsoft.Cdn/preview/2019-06-15-preview/cdnwebapplicationfirewall.json
  - Microsoft.Cdn/stable/2019-04-15/cdn.json
  - Microsoft.Cdn/stable/2017-10-12/cdn.json
  - Microsoft.Cdn/stable/2017-04-02/cdn.json
  - Microsoft.Cdn/stable/2016-10-02/cdn.json
  - Microsoft.Cdn/stable/2016-04-02/cdn.json
  - Microsoft.Cdn/stable/2015-06-01/cdn.json

```