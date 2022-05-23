# JS

- `[[PackageName]]`: It must start with `@azure-rest/`. If the `[[PackageFolder]]` which is `database-rest`, the `[[PackageName]]` should be `@azure-rest/database`.
- `[[Description]]`: It describes the sdk. For example: `Database Client`.
- `[[PackageVersion]]`: It is the version of sdk you want to generate. For example: `1.0.0-beta.1`.
- `[[CredentialScopes]]` It should be same as the `[[SecurityScopes]]` in `readme.md`.
- `[[PathToReadmeMdInSwaggerRepo]]`: It's the path to the `readme.md` file in swagger repository. For example:  `https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/database/data-plane/readme.md`

## Configuration

```yaml
package-name: [[PackageName]]
description: [[Description]]
generate-metadata: true
license-header: MICROSOFT_MIT_NO_VERSION
output-folder: ../
source-code-folder-path: ./src
require:
  - [[PathToReadmeMdInSwaggerRepo]]
package-version: [[PackageVersion]]
rest-level-client: true
add-credentials: true
credential-scopes: [[CredentialScopes]]
use-extension:
  "@autorest/typescript": "6.0.0-beta.19"
```