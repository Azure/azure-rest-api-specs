# SreAgent

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.App SRE Agent service.

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

``` yaml
openapi-type: arm
tag: package-2026-07-01

```

### Tag: package-2026-07-01
These settings apply only when `--tag=package-2026-07-01` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01'
input-file:
  - stable/2026-07-01/sreagent.json
directive:
  - suppress: AvoidAdditionalProperties
    from: sreagent.json
    reason: A dictionary allows passing through service-specific key-value pairs.
    where:
      - $.definitions.AgentConnectorProperties.properties.extendedProperties
      - $.definitions.AgentConnectorPropertiesWithSecrets.properties.extendedProperties
      - $.definitions.Connector.properties.extendedProperties

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
    - $.definitions.Connector.properties.extendedProperties

```