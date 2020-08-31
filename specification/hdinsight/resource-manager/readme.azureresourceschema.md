## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.HDInsight/stable/2018-06-01-preview/cluster.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/applications.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/locations.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/configurations.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/extensions.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/scriptActions.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/operations.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/virtualMachines.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/cluster.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/applications.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/locations.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/configurations.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/extensions.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/scriptActions.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/operations.json

```