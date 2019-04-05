# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Subscriptions.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/AcquiredPlan.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProvider.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProviderOffer.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/DirectoryTenant.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Location.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Offer.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/OfferDelegation.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Plan.json
  - $(this-folder)/Microsoft.Subscriptions.Admin/preview/2015-11-01/Quota.json
require: $(this-folder)/../../../../../profiles/readme.md
```
