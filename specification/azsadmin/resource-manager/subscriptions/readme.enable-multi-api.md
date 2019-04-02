# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/Subscriptions.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/AcquiredPlan.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProvider.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/DelegatedProviderOffer.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/DirectoryTenant.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/Location.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/Offer.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/OfferDelegation.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/Plan.json
  - Microsoft.Subscriptions.Admin/preview/2015-11-01/Quota.json
require: ../../../../../profiles/readme.md
```
