## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_mgmt_web
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: package-2015-08-certificate-registration
  - tag: package-2015-04-domain-registration
  - tag: package-2016-09-01-web
  - tag: package-2016-08-01-web
  - tag: package-2016-03-01-web
  - tag: package-2019-08-01-web
```

### Tag: package-2015-08-certificate-registration and ruby

These settings apply only when `--tag=package-2015-08-certificate-registration --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-08-certificate-registration' && $(ruby)
namespace: "Azure::Web::Mgmt::V2015_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_web/lib
title: "WebSiteManagementClient"
```

### Tag: package-2015-04-domain-registration and ruby

These settings apply only when `--tag=package-2015-04-domain-registration --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2015-04-domain-registration' && $(ruby)
namespace: "Azure::Web::Mgmt::V2015_04_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_web/lib
title: "WebSiteManagementClient"
```

### Tag: package-2016-09-01-web and ruby

These settings apply only when `--tag=package-2016-09-01-web --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-09-01-web' && $(ruby)
namespace: "Azure::Web::Mgmt::V2016_09_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_web/lib
title: "WebSiteManagementClient"
```

### Tag: package-2016-08-01-web and ruby

These settings apply only when `--tag=package-2016-08-01-web --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-08-01-web' && $(ruby)
namespace: "Azure::Web::Mgmt::V2016_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_web/lib
title: "WebSiteManagementClient"
```

### Tag: package-2016-03-01-web and ruby

These settings apply only when `--tag=package-2016-03-01-web --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2016-03-01-web' && $(ruby)
namespace: "Azure::Web::Mgmt::V2016_03_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_web/lib
title: "WebSiteManagementClient"
```

### Tag: package-2019-08-01-web and ruby

These settings apply only when `--tag=package-2019-08-01-web --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-2019-08-01-web' && $(ruby)
namespace: "Azure::Web::Mgmt::V2019_08_01"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_web/lib
title: "WebSiteManagementClient"
```
