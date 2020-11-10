## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-hdinsight-2018-06-01-preview
  - tag: schema-hdinsight-2015-03-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-hdinsight-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-hdinsight-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HDInsight/stable/2018-06-01-preview/cluster.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/applications.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/locations.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/configurations.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/extensions.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/scriptActions.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/operations.json
  - Microsoft.HDInsight/stable/2018-06-01-preview/virtualMachines.json

```

### Tag: schema-hdinsight-2015-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-hdinsight-2015-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.HDInsight/preview/2015-03-01-preview/cluster.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/applications.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/locations.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/configurations.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/extensions.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/scriptActions.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/operations.json

```
