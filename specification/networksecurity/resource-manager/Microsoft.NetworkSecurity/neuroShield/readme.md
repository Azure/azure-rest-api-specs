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

For TypeSpec SDK generation, select this directory's `tspconfig.yaml`; its current
source entry point is `main.tsp`. It contains only the public NeuroShield service.
There is no `client.tsp` customization or multi-service composition in this
project. Existing service/client naming and NeuroShield operation groups are
retained; package namespaces do not rename the REST service.

Outputs are rooted at `sdk/networksecurity`, with a package-specific subdirectory
for each language. Go instead uses
`sdk/resourcemanager/networksecurity/armnetworksecurity`. Run the selected SDK
repository's standard generation, build, and validation workflow using this
configuration; the TypeSpec compile command above regenerates OpenAPI, not SDKs.

### Adding another public NetworkSecurity service

Agent Fabric must not be added to this generation input until its specification
is public. When onboarding it, coordinate one generation entry point and
configuration per shared package with the NetworkSecurity SDK owners. The
[Network SDK client entry point](../../../../network/resource-manager/Microsoft.Network/Network/client.tsp)
demonstrates importing multiple public service definitions from one SDK input.
Add imports for NeuroShield and Agent Fabric to the agreed SDK entry point, then
validate the intended client hierarchy rather than assuming imports or equal
package names merge clients.

Retain distinct service operation groups and review collisions in client names,
models, operations, and shared `Operations` APIs, as well as API-version and
dependency compatibility. Agree on shared release ownership and obtain SDK
architect approval for package and client names; package-name reservation alone
is not approval. Update generation inputs in each SDK repository together, then
run metadata extraction, TypeSpec validation, and each affected language's SDK
generation/build checks before publishing. Do not generate independent services
sequentially into the same package output directory: this can overwrite files
instead of composing the package.

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
