## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-media-2020-05-01
  - tag: schema-media-2020-02-01-preview
  - tag: schema-media-2019-09-01-preview
  - tag: schema-media-2019-05-01-preview
  - tag: schema-media-2018-07-01
  - tag: schema-media-2018-06-01-preview
  - tag: schema-media-2018-03-30-preview
  - tag: schema-media-2015-10-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-media-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-media-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/stable/2020-05-01/AccountFilters.json
  - Microsoft.Media/stable/2020-05-01/Accounts.json
  - Microsoft.Media/stable/2020-05-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2020-05-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2020-05-01/Encoding.json
  - Microsoft.Media/stable/2020-05-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2020-05-01/streamingservice.json
  - Microsoft.Media/stable/2020-05-01/Common.json

```

### Tag: schema-media-2020-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-media-2020-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/preview/2020-02-01-preview/MediaGraphs.json

```

### Tag: schema-media-2019-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-media-2019-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/preview/2019-09-01-preview/MediaGraphs.json

```

### Tag: schema-media-2019-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-media-2019-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/preview/2019-05-01-preview/AccountFilters.json
  - Microsoft.Media/preview/2019-05-01-preview/Accounts.json
  - Microsoft.Media/preview/2019-05-01-preview/AssetsAndAssetFilters.json
  - Microsoft.Media/preview/2019-05-01-preview/Common.json
  - Microsoft.Media/preview/2019-05-01-preview/ContentKeyPolicies.json
  - Microsoft.Media/preview/2019-05-01-preview/Encoding.json
  - Microsoft.Media/preview/2019-05-01-preview/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/preview/2019-05-01-preview/streamingservice.json

```

### Tag: schema-media-2018-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-media-2018-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/stable/2018-07-01/AccountFilters.json
  - Microsoft.Media/stable/2018-07-01/Accounts.json
  - Microsoft.Media/stable/2018-07-01/AssetsAndAssetFilters.json
  - Microsoft.Media/stable/2018-07-01/ContentKeyPolicies.json
  - Microsoft.Media/stable/2018-07-01/Encoding.json
  - Microsoft.Media/stable/2018-07-01/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/stable/2018-07-01/streamingservice.json
  - Microsoft.Media/stable/2018-07-01/Common.json

```

### Tag: schema-media-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-media-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/preview/2018-06-01-preview/Accounts.json
  - Microsoft.Media/preview/2018-06-01-preview/Assets.json
  - Microsoft.Media/preview/2018-06-01-preview/ContentKeyPolicies.json
  - Microsoft.Media/preview/2018-06-01-preview/Encoding.json
  - Microsoft.Media/preview/2018-06-01-preview/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/preview/2018-06-01-preview/streamingservice.json

```

### Tag: schema-media-2018-03-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-media-2018-03-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/preview/2018-03-30-preview/Accounts.json
  - Microsoft.Media/preview/2018-03-30-preview/Assets.json
  - Microsoft.Media/preview/2018-03-30-preview/ContentKeyPolicies.json
  - Microsoft.Media/preview/2018-03-30-preview/Encoding.json
  - Microsoft.Media/preview/2018-03-30-preview/StreamingPoliciesAndStreamingLocators.json
  - Microsoft.Media/preview/2018-03-30-preview/streamingservice.json

```

### Tag: schema-media-2015-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-media-2015-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Media/stable/2015-10-01/media.json

```
