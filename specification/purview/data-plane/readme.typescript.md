## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

```yaml $(typescript)
rest-level-client: true
add-credentials: true
license-header: MICROSOFT_MIT_NO_VERSION
generate-metadata: true
```

``` yaml $(typescript) && !$(multi-client)
batch:
  - package-catalog: true
  - package-scanning: true
```

```yaml $(typescript) && $(multi-client) == 'package-administration'
package-name: "@azure-rest/purview-administration"
description: Purview Administration Client
output-folder: "$(typescript-sdks-folder)/sdk/purview/purview-administration-rest"
package-version: 1.0.0-beta.2
batch:
  - package-account: true
  - package-metadata: true
```

``` yaml $(package-account)
source-code-folder-path: ./src/account
```

``` yaml $(package-metadata)
source-code-folder-path: ./src/metadataPolicies
```

``` yaml $(package-catalog)
package-name: "@azure-rest/purview-catalog"
description: Purview Catalog Client
output-folder: "$(typescript-sdks-folder)/sdk/purview/purview-catalog-rest"
package-version: 1.0.0-beta.1
```

``` yaml $(package-scanning)
package-name: "@azure-rest/purview-scanning"
description: Purview Scanning Client
output-folder: "$(typescript-sdks-folder)/sdk/purview/purview-scanning-rest"
package-version: 1.0.0-beta.1
```
