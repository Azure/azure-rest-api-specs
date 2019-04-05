# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.HDInsight/preview/2018-06-01-preview/cluster.json
  - $(this-folder)/Microsoft.HDInsight/preview/2018-06-01-preview/applications.json
  - $(this-folder)/Microsoft.HDInsight/preview/2018-06-01-preview/locations.json
  - $(this-folder)/Microsoft.HDInsight/preview/2018-06-01-preview/configurations.json
  - $(this-folder)/Microsoft.HDInsight/preview/2018-06-01-preview/extensions.json
  - $(this-folder)/Microsoft.HDInsight/preview/2018-06-01-preview/scriptActions.json
  - $(this-folder)/Microsoft.HDInsight/preview/2018-06-01-preview/operations.json
  - $(this-folder)/Microsoft.HDInsight/preview/2015-03-01-preview/cluster.json
  - $(this-folder)/Microsoft.HDInsight/preview/2015-03-01-preview/applications.json
  - $(this-folder)/Microsoft.HDInsight/preview/2015-03-01-preview/locations.json
  - $(this-folder)/Microsoft.HDInsight/preview/2015-03-01-preview/configurations.json
  - $(this-folder)/Microsoft.HDInsight/preview/2015-03-01-preview/extensions.json
  - $(this-folder)/Microsoft.HDInsight/preview/2015-03-01-preview/scriptActions.json
  - $(this-folder)/Microsoft.HDInsight/preview/2015-03-01-preview/operations.json
require: $(this-folder)/../../../../profiles/readme.md
```
