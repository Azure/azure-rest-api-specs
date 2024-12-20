# Azure Key Vault TypeSpec Specification (Administration SDK)

The TypeSpec specification for Azure Key Vault's Administration SDK library.

This specification is client library-specific and is only meant to be a convenience for client library generation.
Aside from client customizations in `client.tsp`, this directory only consolidates the specifications for the Key Vault
subservices that comprise the Administration SDK: [BackupRestore][backup_restore], [RBAC][rbac], and [Settings][settings].

Client SDKs that need a single generation point should use this directory, either producing a single client by default
or defining multiple clients in `client.tsp`. SDKs that need separate packages for each subservice should instead use
the subservice directories as generation points, and make any client customizations with `client.tsp`s in those
directories.

## Development environment

Instructions for installing TypeSpec and generating SDK code with `tsp-client` are documented at
[azure.github.io][typespec_docs].

## Contents

### `administration.tsp`
This file imports the relevant specifications from each of the Administration subservices. This includes shared
definitions from [`Security.KeyVault.Common`][common]; model and route definitions from [BackupRestore][backup_restore],
[RBAC][rbac], and [Settings][settings]; and a `main.tsp` file from any one of these subservices. The `main.tsp` files
of each subservice are equivalent and importing more than one will cause errors due to duplicated definitions.

### `client.tsp`
This file makes client SDK customizations, such as model renamings and client definitions.

### `tspconfig.yaml`
This configuration file is necessary to generate client SDKs. Configuration for OpenAPI spec generation (under
`"@azure-tools/typespec-autorest":`) is present to satisfy automated validation checks, but this spec shouldn't actually
be generated or included in PRs since this would duplicate specs for each subservice.

### `examples`
Present for validation checks; these are duplicates of the examples for each subservice.


<!-- LINKS -->

[backup_restore]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/keyvault/Security.KeyVault.BackupRestore
[common]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/keyvault/Security.KeyVault.Common
[rbac]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/keyvault/Security.KeyVault.RBAC
[settings]: https://github.com/Azure/azure-rest-api-specs/tree/main/specification/keyvault/Security.KeyVault.Settings
[typespec_docs]: https://azure.github.io/typespec-azure/docs/intro/
