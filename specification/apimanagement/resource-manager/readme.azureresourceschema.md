## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-apimanagement-2020-06-01-preview
  - tag: schema-apimanagement-2019-12-01-preview
  - tag: schema-apimanagement-2019-12-01
  - tag: schema-apimanagement-2019-01-01
  - tag: schema-apimanagement-2018-06-01-preview
  - tag: schema-apimanagement-2018-01-01
  - tag: schema-apimanagement-2017-03-01
  - tag: schema-apimanagement-2016-10-10
  - tag: schema-apimanagement-2016-07-07

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-apimanagement-2020-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2020-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimanagement.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimapis.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimapisByTags.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimapiversionsets.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimauthorizationservers.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimbackends.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimcaches.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimcertificates.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimcontenttypes.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimdeletedservices.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimdeployment.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimdiagnostics.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimemailtemplates.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimgateways.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimgroups.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimidentityprovider.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimissues.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimloggers.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimnamedvalues.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimnetworkstatus.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimnotifications.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimpolicies.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimpolicydescriptions.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimportalsettings.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimproducts.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimproductsByTags.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimquotas.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimregions.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimreports.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimsubscriptions.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimtagresources.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimtags.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimtenant.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/apimusers.json
  - Microsoft.ApiManagement/preview/2020-06-01-preview/definitions.json

```

### Tag: schema-apimanagement-2019-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2019-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimanagement.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimapis.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimapisByTags.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimapiversionsets.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimauthorizationservers.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimbackends.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimcaches.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimcertificates.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimdeployment.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimdiagnostics.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimemailtemplates.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimgateways.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimgroups.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimidentityprovider.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimissues.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimloggers.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimnetworkstatus.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimnotifications.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimpolicies.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimpolicydescriptions.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimportalsettings.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimproducts.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimproductsByTags.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimnamedvalues.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimquotas.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimregions.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimreports.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimsubscriptions.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimtagresources.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimtags.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimtenant.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/apimusers.json
  - Microsoft.ApiManagement/preview/2019-12-01-preview/definitions.json

```

### Tag: schema-apimanagement-2019-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2019-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/stable/2019-12-01/apimanagement.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimapis.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimapisByTags.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimapiversionsets.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimauthorizationservers.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimbackends.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimcaches.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimcertificates.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimcontenttypes.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimdeployment.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimdiagnostics.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimemailtemplates.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimgateways.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimgroups.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimidentityprovider.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimissues.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimloggers.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimnamedvalues.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimnetworkstatus.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimnotifications.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimpolicies.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimpolicydescriptions.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimportalsettings.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimproducts.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimproductsByTags.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimquotas.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimregions.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimreports.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimsubscriptions.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimtagresources.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimtags.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimtenant.json
  - Microsoft.ApiManagement/stable/2019-12-01/apimusers.json
  - Microsoft.ApiManagement/stable/2019-12-01/definitions.json

```

### Tag: schema-apimanagement-2019-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2019-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/stable/2019-01-01/apimanagement.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimapis.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimapisByTags.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimapiversionsets.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimauthorizationservers.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimbackends.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimcaches.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimcertificates.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimdeployment.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimdiagnostics.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimemailtemplates.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimgroups.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimidentityprovider.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimissues.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimloggers.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimnetworkstatus.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimnotifications.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimpolicies.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimpolicysnippets.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimportalsettings.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimproducts.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimproductsByTags.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimproperties.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimquotas.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimregions.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimreports.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimsubscriptions.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimtagresources.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimtags.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimtenant.json
  - Microsoft.ApiManagement/stable/2019-01-01/apimusers.json
  - Microsoft.ApiManagement/stable/2019-01-01/definitions.json

```

### Tag: schema-apimanagement-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimanagement.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimapis.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimapisByTags.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimauthorizationservers.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimbackends.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimcaches.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimcertificates.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimdeployment.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimdiagnostics.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimemailtemplates.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimgroups.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimidentityprovider.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimissues.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimloggers.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimnotifications.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimnetworkstatus.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimpolicies.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimpolicysnippets.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimportalsettings.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimproducts.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimproductsByTags.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimproperties.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimquotas.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimregions.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimreports.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimsubscriptions.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimtagresources.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimtags.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimtenant.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimusers.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/apimapiversionsets.json
  - Microsoft.ApiManagement/preview/2018-06-01-preview/definitions.json

```

### Tag: schema-apimanagement-2018-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2018-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/stable/2018-01-01/apimanagement.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimapis.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimauthorizationservers.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimbackends.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimcertificates.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimdeployment.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimdiagnostics.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimemailtemplate.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimgroups.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimidentityprovider.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimloggers.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimnotifications.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimnetworkstatus.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimportalsettings.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimproducts.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimproperties.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimquotas.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimreports.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimsubscriptions.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimtagresources.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimtags.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimtenant.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimusers.json
  - Microsoft.ApiManagement/stable/2018-01-01/apimversionsets.json

```

### Tag: schema-apimanagement-2017-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2017-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/stable/2017-03-01/apimanagement.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimapis.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimauthorizationservers.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimbackends.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimcertificates.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimdeployment.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimdiagnostics.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimemailtemplate.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimgroups.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimidentityprovider.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimloggers.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimnotifications.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimnetworkstatus.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimportalsettings.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimproducts.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimproperties.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimquotas.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimreports.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimsubscriptions.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimtagresources.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimtags.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimtenant.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimusers.json
  - Microsoft.ApiManagement/stable/2017-03-01/apimversionsets.json

```

### Tag: schema-apimanagement-2016-10-10 and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2016-10-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/stable/2016-10-10/apimanagement.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimapis.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimauthorizationservers.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimbackends.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimcertificates.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimdeployment.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimgroups.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimidentityprovider.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimloggers.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimnetworkstatus.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimopenidconnectproviders.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimproducts.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimproperties.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimquotas.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimreports.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimsubscriptions.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimtenant.json
  - Microsoft.ApiManagement/stable/2016-10-10/apimusers.json

```

### Tag: schema-apimanagement-2016-07-07 and azureresourceschema

``` yaml $(tag) == 'schema-apimanagement-2016-07-07' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ApiManagement/stable/2016-07-07/apimanagement.json
  - Microsoft.ApiManagement/stable/2016-07-07/apimdeployment.json

```
