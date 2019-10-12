## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: insights
  clear-output-folder: true
```

### Go mult-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-05
```

### Tag: package-2015-05 and go

These settings apply only when `--tag=package-2015-05 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05' && $(go)
output-folder: $(go-sdk-folder)/services/appinsights/mgmt/2015-05-01/$(namespace)
```

### Tag: schema-2015-05-preview

These settings apply only when `--tag=schema-2015-05-01` is specified on the
command line.

This section contains the input swagger files that are used when generating
resource manager schemas for version 2015-05-01. Note that many of our
pre-existing APIs are note currently compatible with ARM schemas, upon any
updates applied to our services we will bring them up to compliance.

``` yaml $(tag) == 'schema-2015-05-01'
input-file:
 - ./Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
 - ./Microsoft.Insights/stable/2015-05-01/components_API.json
 - ./Microsoft.Insights/stable/2015-05-01/webTests_API.json
 - ./Microsoft.Insights/stable/2015-05-01/workbooks_API.json

override-info:
  title: ApplicationInsightsManagementClient
```
