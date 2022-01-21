## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
batch:
  - package-account: true
  - package-catalog: true
  - package-scanning: true

rest-level-client: true
add-credentials: true
license-header: MICROSOFT_MIT_NO_VERSION
generate-metadata: false
source-code-folder-path: "src"
```

``` yaml $(package-account)
package-name: "@azure-rest/purview-account"
description: Purview Account Client
output-folder: "$(typescript-sdks-folder)/sdk/purview/purview-account-rest"
package-version: 1.0.0-beta.1

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
