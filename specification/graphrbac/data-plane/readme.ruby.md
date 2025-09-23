## Ruby

These settings apply only when `--ruby` is specified on the command line.

``` yaml
package-name: azure_graph_rbac
package-version: "0.16.0"
azure-arm: true
```

### Ruby multi-api

``` yaml $(ruby) && $(multiapi)
batch:
  - tag: 1.6
```

### Tag: 1.6 and ruby

These settings apply only when `--tag=1.6 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == '1.6' && $(ruby)
namespace: "Azure::GraphRbac::V1_6"
output-folder: $(ruby-sdks-folder)/data/azure_graph_rbac/lib
title: GraphRbacClient
```
