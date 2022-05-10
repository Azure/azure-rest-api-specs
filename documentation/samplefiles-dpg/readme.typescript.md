## TypeScript

- `[[PackageName]]` must start with `@azure-rest/`. For example: `@azure-rest/database`.
- `[[Description]]` describes the sdk. For example: `Database Client`.
- `[[PackageVersion]]` is the version of sdk you want to generate. For example: `1.0.0-beta.1`.
- Please specify `--typescript-sdks-folder=<path to root folder of your azure-sdk-for-js clone>` in autorest command.
- `[[ServiceFolder]]` is better same with folder name in swagger repo.
- If `[[PackageName]]` is `@azure-rest/database`, then `[[PackageFolder]]` shall be `database-rest`.
- `[[CredentialScopes]]` should be same as the `[[SecurityScopes]]` in `readme.md`.

```yaml $(typescript)
typescript:
  package-name: [[PackageName]]
  description: [[Description]]
  package-version: [[PackageVersion]]
  output-folder: "$(typescript-sdks-folder)/sdk/[[ServiceFolder]]/[[PackageFolder]]"
  rest-level-client: true
  add-credentials: true
  license-header: MICROSOFT_MIT_NO_VERSION
  generate-metadata: true
  credential-scopes: [[CredentialScopes]]