## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-web-2020-06-01
  - tag: schema-web-2019-08-01
  - tag: schema-web-2018-11-01
  - tag: schema-web-2018-02-01
  - tag: schema-web-2016-09-01
  - tag: schema-web-2016-08-01
  - tag: schema-web-2016-03-01
  - tag: schema-web-2015-08-01-preview
  - tag: schema-web-2015-08-01
  - tag: schema-domainregistration-2020-06-01
  - tag: schema-domainregistration-2019-08-01
  - tag: schema-domainregistration-2018-02-01
  - tag: schema-domainregistration-2015-04-01
  - tag: schema-certificateregistration-2020-06-01
  - tag: schema-certificateregistration-2019-08-01
  - tag: schema-certificateregistration-2018-02-01
  - tag: schema-certificateregistration-2015-08-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-web-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
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

```

### Tag: schema-web-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
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

```

### Tag: schema-web-2018-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2018-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Web/stable/2018-11-01/Certificates.json
  - Microsoft.Web/stable/2018-11-01/WebApps.json

```

### Tag: schema-web-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Web/stable/2018-02-01/CommonDefinitions.json
  - Microsoft.Web/stable/2018-02-01/DeletedWebApps.json
  - Microsoft.Web/stable/2018-02-01/Diagnostics.json
  - Microsoft.Web/stable/2018-02-01/Provider.json
  - Microsoft.Web/stable/2018-02-01/Recommendations.json
  - Microsoft.Web/stable/2018-02-01/ResourceProvider.json
  - Microsoft.Web/stable/2018-02-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2018-02-01/AppServicePlans.json
  - Microsoft.Web/stable/2018-02-01/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2018-02-01/WebApps.json
  - Microsoft.Web/stable/2018-02-01/Certificates.json

```

### Tag: schema-web-2016-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2016-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Web/stable/2016-09-01/AppServiceEnvironments.json
  - Microsoft.Web/stable/2016-09-01/AppServicePlans.json

```

### Tag: schema-web-2016-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2016-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Web/stable/2016-08-01/WebApps.json

```

### Tag: schema-web-2016-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2016-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Web/stable/2016-03-01/Certificates.json
  - Microsoft.Web/stable/2016-03-01/CommonDefinitions.json
  - Microsoft.Web/stable/2016-03-01/DeletedWebApps.json
  - Microsoft.Web/stable/2016-03-01/Diagnostics.json
  - Microsoft.Web/stable/2016-03-01/Provider.json
  - Microsoft.Web/stable/2016-03-01/Recommendations.json
  - Microsoft.Web/stable/2016-03-01/ResourceHealthMetadata.json
  - Microsoft.Web/stable/2016-03-01/ResourceProvider.json

```

### Tag: schema-web-2015-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-web-2015-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Web/preview/2015-08-01-preview/logicAppsManagementClient.json

```

### Tag: schema-web-2015-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-web-2015-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Web/stable/2015-08-01/service.json

```

### Tag: schema-domainregistration-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-domainregistration-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DomainRegistration/stable/2020-06-01/Domains.json
  - Microsoft.DomainRegistration/stable/2020-06-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2020-06-01/DomainRegistrationProvider.json

```

### Tag: schema-domainregistration-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-domainregistration-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DomainRegistration/stable/2019-08-01/Domains.json
  - Microsoft.DomainRegistration/stable/2019-08-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2019-08-01/DomainRegistrationProvider.json

```

### Tag: schema-domainregistration-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-domainregistration-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DomainRegistration/stable/2018-02-01/Domains.json
  - Microsoft.DomainRegistration/stable/2018-02-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2018-02-01/DomainRegistrationProvider.json

```

### Tag: schema-domainregistration-2015-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-domainregistration-2015-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DomainRegistration/stable/2015-04-01/Domains.json
  - Microsoft.DomainRegistration/stable/2015-04-01/TopLevelDomains.json
  - Microsoft.DomainRegistration/stable/2015-04-01/DomainRegistrationProvider.json

```

### Tag: schema-certificateregistration-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-certificateregistration-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CertificateRegistration/stable/2020-06-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2020-06-01/CertificateRegistrationProvider.json

```

### Tag: schema-certificateregistration-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-certificateregistration-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CertificateRegistration/stable/2019-08-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2019-08-01/CertificateRegistrationProvider.json

```

### Tag: schema-certificateregistration-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-certificateregistration-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CertificateRegistration/stable/2018-02-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2018-02-01/CertificateRegistrationProvider.json

```

### Tag: schema-certificateregistration-2015-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-certificateregistration-2015-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.CertificateRegistration/stable/2015-08-01/AppServiceCertificateOrders.json
  - Microsoft.CertificateRegistration/stable/2015-08-01/CertificateRegistrationProvider.json

```
