# Microsoft.NetworkSecurity NeuroShield

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.NetworkSecurity NeuroShield management service.

## TypeSpec

This project defines `2026-10-01-preview`. Edit the TypeSpec source and examples
under `examples/2026-10-01-preview`, then regenerate the OpenAPI and mirrored
examples from this directory:

```text
pnpm exec tsp compile . --warn-as-error
```

Commit the generated files under `preview/2026-10-01-preview` together with the
source changes. Do not edit the generated OpenAPI directly.

## Getting Started

### Shared NetworkSecurity SDK packages

The language options in `tspconfig.yaml` target these shared package identities:

| Language              | Package                                                                                    | Namespace                                   |
| --------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------- |
| .NET                  | `Azure.ResourceManager.NetworkSecurity`                                                    | `Azure.ResourceManager.NetworkSecurity`     |
| Python                | `azure-mgmt-networksecurity`                                                               | `azure.mgmt.networksecurity`                |
| Java                  | `com.azure.resourcemanager:azure-resourcemanager-networksecurity`                          | `com.azure.resourcemanager.networksecurity` |
| JavaScript/TypeScript | `@azure/arm-networksecurity`                                                               | Not applicable                              |
| Go                    | `github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/networksecurity/armnetworksecurity` | `armnetworksecurity`                        |

For TypeSpec SDK generation, select this directory's `tspconfig.yaml`. The SDK
generator loads `client.tsp`, which imports `main.tsp` and applies language-scoped
client naming. The REST entry point `main.tsp` also imports `client.tsp`, as
required by repository validation, so both entry points load the same SDK
customizations. Only the public NeuroShield service is included. The SDK naming
overrides do not change routes, API versions, wire models, operation IDs, or
paging parameters.

Outputs are rooted at `sdk/networksecurity`, with a package-specific subdirectory
for each language. Go instead uses
`sdk/resourcemanager/networksecurity/armnetworksecurity`. Run the selected SDK
repository's standard generation, build, and validation workflow using this
configuration; the TypeSpec compile command above regenerates OpenAPI, not SDKs.

### NeuroShield SDK surface

The shared package does not require identical client hierarchies in every
language. NeuroShield is distinguished by these generated surfaces:

| Language              | Client organization                                                                                                                                  | Models                                                                                                 |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| .NET                  | `NeuroShieldResource`, `NeuroShieldProtectedResource`, and the other NeuroShield resources/collections under `Azure.ResourceManager.NetworkSecurity` | Resource data in the package namespace; other models in `Azure.ResourceManager.NetworkSecurity.Models` |
| Python                | `azure.mgmt.networksecurity.NeuroShieldManagementClient`, with the asynchronous client in `azure.mgmt.networksecurity.aio`                           | `azure.mgmt.networksecurity.models`; operation groups in `azure.mgmt.networksecurity.operations`       |
| Java                  | `com.azure.resourcemanager.networksecurity.NetworkSecurityManager`, with `NetworkSecurityManagementClient` under `.fluent`                           | NeuroShield models and fluent operation groups under `.models`                                         |
| JavaScript/TypeScript | `NeuroShieldManagementClient` exported from `@azure/arm-networksecurity`, with NeuroShield operation-group properties                                | NeuroShield models exported from the package root                                                      |
| Go                    | `armnetworksecurity.ClientFactory` creates the six NeuroShield operation clients and `OperationsClient`; each client also has its normal constructor | NeuroShield-prefixed types in `armnetworksecurity`                                                     |

The seven operation groups are `Operations`, `NeuroShieldOperationStatuses`,
`NeuroShields`, `NeuroShieldSummaries`, `NeuroShieldProtectedResources`,
`NeuroShieldFindings`, and `NeuroShieldMitigations`. SDK naming stays in
`client.tsp`; Java's human-readable `service-name` option also controls its
manager name. Do not rename REST declarations to change these SDK names.

### Adding another public NetworkSecurity service

Two-service generation is not implemented here. Agent Fabric must not be added
until its definitions are authorized for the public generation input. The
[Network SDK client entry point](../../../../network/resource-manager/Microsoft.Network/Network/client.tsp)
imports multiple public services and explicitly combines them with a TypeSpec
client generator core `@client` declaration using a service array and
`autoMergeService`. IPAM is an operation group within the Network package, not a
separate installable package.
That is composition prior art, not evidence that NeuroShield and Agent Fabric
have already been generated together.

Onboard Agent Fabric as a coordinated change with the shared SDK owners:

1. Publish only the authorized Agent Fabric REST input through its own API review.
   Keep NeuroShield's REST entry point and contract unchanged. Do not copy private
   definitions or introduce placeholder service definitions here.
2. Extend this directory's `client.tsp` to import the approved public Agent Fabric
   entry point. Retain this `tspconfig.yaml` as the single shared-package generation
   configuration. If the owners instead relocate the SDK input to a common project,
   migrate all SDK generation references together and retire the old package writer.
3. Define and validate the client composition explicitly with the supported SDK
   tools. Preserve the existing NeuroShield exports. Python and TypeScript should
   retain their service-specific client; Java should expose distinct operation
   groups through the shared manager. Preserve .NET's resource/collection pattern
   and Go's shared factory with distinct operation clients. Check each emitter's
   support before choosing multiple clients or an aggregate client; imports alone
   are insufficient. Do not assume the Network aggregate declaration can be copied
   unchanged across different service versions and dependencies.
4. Resolve collisions before emitting into a shared directory: client names,
   operation groups, model/enum names, generated file names, and exported symbols.
   Review duplicate provider `Operations` APIs explicitly; share one SDK group only
   when the REST operation and version semantics match. Use scoped SDK naming or
   composition customizations, not REST renames, to distinguish service-owned types.
5. Point each SDK repository's `tsp-location.yaml` at the same public generation
   project and an approved spec commit containing both services. Generate once per
   language/package into the output paths above. Never run independent NeuroShield
   and Agent Fabric generation sequentially into the same output directory: the
   second run can overwrite the first service's clients, models, and exports.
6. Validate both services' operation inventories, model exports/imports, API-version
   selection, and dependency compatibility; then build and test all five packages.
   Compare the regenerated REST artifacts and the existing NeuroShield SDK surface
   for unintended changes. Coordinate package versions, releases, and ownership.

Obtain SDK architect approval for package and client names before release.
Package-name reservation is not approval. Combined generation remains unverified
until the authorized Agent Fabric input is included and all language checks pass.

### PowerShell and Azure CLI

Swagger-based PowerShell and Azure CLI tooling can select the AutoRest input and
version tag below. The SDK-only `client.tsp` names do not define PowerShell module
or cmdlet names, or Azure CLI extensions or command groups. Those require their
own approved design and generation configuration in the respective tooling
repositories. PowerShell/CLI generation and tests are not implemented by this
SDK packaging configuration. Do not change REST routes, operation IDs, models,
or `$top`/`$skipToken` solely to choose those names.

### AutoRest input

For tooling that consumes OpenAPI rather than TypeSpec, install AutoRest via
`npm` and use this README's input configuration:

> `autorest readme.md`

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-10-01-preview
```

### Tag: package-2026-10-01-preview

These settings apply when `--tag=package-2026-10-01-preview` is specified.

```yaml $(tag) == 'package-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/neuroShield.json
```
