## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.Network/stable/2018-05-01/dns.json
  - Microsoft.Network/preview/2018-03-01-preview/dns.json
  - Microsoft.Network/stable/2017-10-01/dns.json
  - Microsoft.Network/stable/2017-09-01/dns.json
  - Microsoft.Network/stable/2016-04-01/dns.json
  - Microsoft.Network/preview/2015-05-04-preview/dns.json

```