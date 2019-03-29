# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.HDInsight/preview/2018-06-01-preview/cluster.json
  - Microsoft.HDInsight/preview/2018-06-01-preview/applications.json
  - Microsoft.HDInsight/preview/2018-06-01-preview/locations.json
  - Microsoft.HDInsight/preview/2018-06-01-preview/configurations.json
  - Microsoft.HDInsight/preview/2018-06-01-preview/extensions.json
  - Microsoft.HDInsight/preview/2018-06-01-preview/scriptActions.json
  - Microsoft.HDInsight/preview/2018-06-01-preview/operations.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/cluster.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/applications.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/locations.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/configurations.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/extensions.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/scriptActions.json
  - Microsoft.HDInsight/preview/2015-03-01-preview/operations.json
```
