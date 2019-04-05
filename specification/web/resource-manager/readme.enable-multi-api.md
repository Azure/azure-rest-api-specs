# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.CertificateRegistration/stable/2018-02-01/AppServiceCertificateOrders.json
  - $(this-folder)/Microsoft.CertificateRegistration/stable/2018-02-01/CertificateRegistrationProvider.json
  - $(this-folder)/Microsoft.DomainRegistration/stable/2018-02-01/Domains.json
  - $(this-folder)/Microsoft.DomainRegistration/stable/2018-02-01/TopLevelDomains.json
  - $(this-folder)/Microsoft.DomainRegistration/stable/2018-02-01/DomainRegistrationProvider.json
  - $(this-folder)/Microsoft.Web/stable/2018-11-01/Certificates.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/CommonDefinitions.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/DeletedWebApps.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/Diagnostics.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/Provider.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/Recommendations.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/ResourceProvider.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/WebApps.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/AppServiceEnvironments.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/AppServicePlans.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/ResourceHealthMetadata.json
  - $(this-folder)/Microsoft.Web/stable/2018-02-01/Certificates.json
  - $(this-folder)/Microsoft.CertificateRegistration/stable/2015-08-01/AppServiceCertificateOrders.json
  - $(this-folder)/Microsoft.CertificateRegistration/stable/2015-08-01/CertificateRegistrationProvider.json
  - $(this-folder)/Microsoft.DomainRegistration/stable/2015-04-01/Domains.json
  - $(this-folder)/Microsoft.DomainRegistration/stable/2015-04-01/TopLevelDomains.json
  - $(this-folder)/Microsoft.DomainRegistration/stable/2015-04-01/DomainRegistrationProvider.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/Certificates.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/CommonDefinitions.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/DeletedWebApps.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/Diagnostics.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/Provider.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/Recommendations.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/ResourceHealthMetadata.json
  - $(this-folder)/Microsoft.Web/stable/2016-03-01/ResourceProvider.json
  - $(this-folder)/Microsoft.Web/stable/2016-08-01/WebApps.json
  - $(this-folder)/Microsoft.Web/stable/2016-09-01/AppServiceEnvironments.json
  - $(this-folder)/Microsoft.Web/stable/2016-09-01/AppServicePlans.json
  - $(this-folder)/Microsoft.Web/stable/2015-08-01/service.json
  - $(this-folder)/Microsoft.Web/preview/2015-08-01-preview/logicAppsManagementClient.json
require: $(this-folder)/../../../../profiles/readme.md
```
