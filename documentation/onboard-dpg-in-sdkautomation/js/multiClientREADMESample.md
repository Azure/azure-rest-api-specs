# JS

- Please add parameter `--multi-client` in running autorest to generate codes.
- `[[PackageName]]`: It must start with `@azure-rest/`. If the `[[PackageFolder]]` which is `database-rest`, the `[[PackageName]]` should be `@azure-rest/database`.
- `[[PackageVersion]]`: It is the version of sdk you want to generate. For example: `1.0.0-beta.1`.
- `[[CredentialScopes]]`: It should be same as the `[[SecurityScopes]]` in `readme.md`.
- `[[TAG_1]]`/`[[TAG_1]]`: The tag to generate sub-client. For example: `database1`/`database2`.
- `[[Title_1]]`/`[[Title_2]]`: The client name of generate codes.
- `[[Description_1]]`/`[[Description_2]]`: It describes the sdk. For example: `Database Client 1`/`Database Client 2`.
- `[[Package_1]]`/`[[Package_2]]`: The sub-folder of generated codes. For example: `database1`/`database2`.
- `[[PathToSwaggerFile_1]]`/`[[PathToSwaggerFile_2]]`: The path to swagger file. For example: `https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/database/data-plane/Azure.Database/stable/2022-07-01/database1.json`

## Configuration

```yaml $(multi-client)
package-name: [[PackageName]]
generate-metadata: true
license-header: MICROSOFT_MIT_NO_VERSION
output-folder: ../
source-code-folder-path: ./src
batch:
  - [[TAG_1]]
  - [[TAG_2]]
package-version: [[PackageVersion]]
rest-level-client: true
add-credentials: true
credential-scopes: [[CredentialScopes]]
use-extension:
  "@autorest/typescript": "6.0.0-beta.19"
```


```yaml $([[TAG_1]]) == true
title: [[Title_1]]
description: [[Description_1]]
output-folder: ../src/[[Package_1]]
source-code-folder-path: ./
input-file: [[PathToSwaggerFile_1]]
```

```yaml $([[TAG_2]]) == true
title: [[Title_2]]
description: [[Description_2]]
output-folder: ../src/[[Package_2]]
source-code-folder-path: ./
input-file: [[PathToSwaggerFile_2]]
```