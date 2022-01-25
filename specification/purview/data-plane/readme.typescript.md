## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
batch:
  ## multi client: package-administration
  - package-administration-account: true
  - package-administration-metadata: true
  ## single client
  - package-catalog: true
  - package-scanning: true

rest-level-client: true
add-credentials: true
license-header: MICROSOFT_MIT_NO_VERSION
generate-metadata: false
source-code-folder-path: "src"
```

``` yaml $(package-administration-account)
package-name: "@azure-rest/purview-administration"
description: Purview Account Client
output-folder: "$(typescript-sdks-folder)/sdk/purview/purview-administration-rest"
source-code-folder-path: ./src/account
package-version: 1.0.0-beta.1
```

``` yaml $(package-administration-metadata)
package-name: "@azure-rest/purview-administration"
description: Purview Metadata Policies Client
output-folder: "$(typescript-sdks-folder)/sdk/purview/purview-administration-rest"
source-code-folder-path: ./src/metadataPolicies
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
