# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/AccountFilters.json
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/Accounts.json
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/AssetsAndAssetFilters.json
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/Common.json
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/ContentKeyPolicies.json
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/Encoding.json
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/StreamingPoliciesAndStreamingLocators.json
  - $(this-folder)/Microsoft.Media/stable/2018-07-01/streamingservice.json
  - $(this-folder)/Microsoft.Media/stable/2015-10-01/media.json
  - $(this-folder)/Microsoft.Media/preview/2018-03-30-preview/Accounts.json
  - $(this-folder)/Microsoft.Media/preview/2018-03-30-preview/Assets.json
  - $(this-folder)/Microsoft.Media/preview/2018-03-30-preview/ContentKeyPolicies.json
  - $(this-folder)/Microsoft.Media/preview/2018-03-30-preview/Encoding.json
  - $(this-folder)/Microsoft.Media/preview/2018-03-30-preview/StreamingPoliciesAndStreamingLocators.json
  - $(this-folder)/Microsoft.Media/preview/2018-03-30-preview/streamingservice.json
  - $(this-folder)/Microsoft.Media/preview/2018-06-01-preview/Accounts.json
  - $(this-folder)/Microsoft.Media/preview/2018-06-01-preview/Assets.json
  - $(this-folder)/Microsoft.Media/preview/2018-06-01-preview/ContentKeyPolicies.json
  - $(this-folder)/Microsoft.Media/preview/2018-06-01-preview/Encoding.json
  - $(this-folder)/Microsoft.Media/preview/2018-06-01-preview/StreamingPoliciesAndStreamingLocators.json
  - $(this-folder)/Microsoft.Media/preview/2018-06-01-preview/streamingservice.json
require: $(this-folder)/../../../../profiles/readme.md
```
