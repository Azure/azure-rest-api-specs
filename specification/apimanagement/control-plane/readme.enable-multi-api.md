# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimanagement.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimapis.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimauthorizationservers.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimbackends.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimcertificates.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimemailtemplate.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimgroups.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimidentityprovider.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimloggers.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimopenidconnectproviders.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimportalsettings.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimproducts.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimproperties.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimquotas.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimreports.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimsubscriptions.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimtenant.json
  - $(this-folder)/Microsoft.ApiManagement/preview/2017-03-01/apimusers.json
require: $(this-folder)/../../../../profiles/readme.md
```
