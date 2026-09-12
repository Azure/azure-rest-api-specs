# SreAgent

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.App SRE Agent service.

## TypeSpec and ARM OpenAPI

`main.tsp` imports the resource operations and models. `agent.models.tsp` defines
the Agent's `vnetConfiguration` and `sandboxConfiguration`, including egress,
private DNS, managed-network access lists, forward-proxy settings, and packages.
The same nested models are used by create/read and PATCH. Responses also expose
read-only `outboundIpAddresses` when the service reports them.

Forward-proxy configuration takes effect only when forward-proxy support is
enabled for the Agent and the egress mode is `AzureVNet`. Supplying proxy settings
does not enable that support; returned settings describe stored configuration.

The `@azure-tools/typespec-autorest` emitter in `tspconfig.yaml` generates
`stable/2026-01-01/sreagent.json` and its example copies. From the repository root,
run:

```powershell
npm exec --no -- tsp compile --list-files --warn-as-error .\specification\app\resource-manager\Microsoft.App\SreAgent
```

Edit TypeSpec and source examples, then regenerate OpenAPI. Do not edit the
generated Swagger directly. Compilation describes the REST API; it does not
deploy the resource provider or establish feature availability.

Bicep resource types are generated downstream from published Swagger through
[Azure/bicep-types-az](https://github.com/Azure/bicep-types-az#re-generating-types-from-swagger).
Updating this specification does not itself release Bicep type definitions,
ARM template reference documentation, or SDK packages.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the SRE Agent.

```yaml
openapi-type: arm
tag: package-2026-01-01

suppressions:
  - code: OperationsAPIImplementation
    reason: The operations API is defined in a separate file.
    from: sreagent.json
  - code: MissingSegmentsInNestedResourceListOperation
    reason: The parent resource Get call is defined in a separate file.
    from: sreagent.json
```

### Tag: package-2026-01-01

These settings apply only when `--tag=package-2026-01-01` is specified on the command line.

```yaml $(tag) == 'package-2026-01-01'
input-file:
  - stable/2026-01-01/sreagent.json
directive:
  - suppress: AvoidAdditionalProperties
    from: sreagent.json
    reason: A dictionary allow passing through various key-value pairs
    where:
      - $.definitions.AgentConnectorProperties.properties.extendedProperties
      - $.definitions.AgentSpaceConnectorProperties.properties.extendedProperties
      - $.definitions.Connector.properties.extendedProperties
```
