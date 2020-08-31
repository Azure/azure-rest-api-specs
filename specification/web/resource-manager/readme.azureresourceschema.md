## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
# include the azure profile definitions from the standard location
require: ../../../profiles/readme.md

output-folder: $(azureresourceschema-folder)/schemas

# all the input files across all versions
input-file:
  - Microsoft.CertificateRegistration/stable/2020-06-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2020-06-01/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2020-06-01/Domains.json
  - Microsoft.DomainRegistration/stable/2020-06-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2020-06-01/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2020-06-01/Certificates.json
  - Microsoft.Web/stable/2020-06-01/CommonDefinitions.json
  - Microsoft.Web/stable/2020-06-01/DeletedWebApps.json
  - Microsoft.Web/stable/2020-06-01/Diagnostics.json
  - Microsoft.Web/stable/2020-06-01/Provider.json
  - Microsoft.Web/stable/2020-06-01/Recommendations.json
  - Microsoft.Web/stable/2020-06-01/ResourceProvider.json
  - Microsoft.Web/stable/2020-06-01/WebApps.json
  - Microsoft.Web/stable/2020-06-01/StaticSites.json
  - Microsoft.Web/stable/2020-06-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2020-06-01/AppServicePlans.json
  - Microsoft.Web/stable/2020-06-01/ResourceHealthMetadata.json
  - Microsoft.CertificateRegistration/stable/2019-08-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2019-08-01/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2019-08-01/Domains.json
  - Microsoft.DomainRegistration/stable/2019-08-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2019-08-01/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2019-08-01/Certificates.json
  - Microsoft.Web/stable/2019-08-01/CommonDefinitions.json
  - Microsoft.Web/stable/2019-08-01/DeletedWebApps.json
  - Microsoft.Web/stable/2019-08-01/Diagnostics.json
  - Microsoft.Web/stable/2019-08-01/Provider.json
  - Microsoft.Web/stable/2019-08-01/Recommendations.json
  - Microsoft.Web/stable/2019-08-01/ResourceProvider.json
  - Microsoft.Web/stable/2019-08-01/WebApps.json
  - Microsoft.Web/stable/2019-08-01/StaticSites.json
  - Microsoft.Web/stable/2019-08-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2019-08-01/AppServicePlans.json
  - Microsoft.Web/stable/2019-08-01/ResourceHealthMetadata.json
  - Microsoft.CertificateRegistration/stable/2018-02-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2018-02-01/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2018-02-01/Domains.json
  - Microsoft.DomainRegistration/stable/2018-02-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2018-02-01/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2018-11-01/Certificates.json
  - Microsoft.Web/stable/2018-02-01/CommonDefinitions.json
  - Microsoft.Web/stable/2018-02-01/DeletedWebApps.json
  - Microsoft.Web/stable/2018-02-01/Diagnostics.json
  - Microsoft.Web/stable/2018-02-01/Provider.json
  - Microsoft.Web/stable/2018-02-01/Recommendations.json
  - Microsoft.Web/stable/2018-02-01/ResourceProvider.json
  - Microsoft.Web/stable/2018-11-01/WebApps.json
  - Microsoft.Web/stable/2018-02-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2018-02-01/AppServicePlans.json
  - Microsoft.Web/stable/2018-02-01/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2018-02-01/WebApps.json
  - Microsoft.Web/stable/2018-02-01/Certificates.json
  - Microsoft.CertificateRegistration/stable/2015-08-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2015-08-01/CertificateRegistrationProvider.json
  - Microsoft.DomainRegistration/stable/2015-04-01/Domains.json
  - Microsoft.DomainRegistration/stable/2015-04-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2015-04-01/DomainRegistrationProvider.json
  - Microsoft.Web/stable/2016-03-01/Certificates.json
  - Microsoft.Web/stable/2016-03-01/CommonDefinitions.json
  - Microsoft.Web/stable/2016-03-01/DeletedWebApps.json
  - Microsoft.Web/stable/2016-03-01/Diagnostics.json
  - Microsoft.Web/stable/2016-03-01/Provider.json
  - Microsoft.Web/stable/2016-03-01/Recommendations.json
  - Microsoft.Web/stable/2016-03-01/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2016-03-01/ResourceProvider.json
  - Microsoft.Web/stable/2016-08-01/WebApps.json
  - Microsoft.Web/stable/2016-09-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2016-09-01/AppServicePlans.json
  - Microsoft.Web/stable/2015-08-01/service.json
  - Microsoft.Web/preview/2015-08-01-preview/logicAppsManagementClient.json

```