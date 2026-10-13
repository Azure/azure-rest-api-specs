# Purview

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview Policy.

---

## Getting Started

To build the SDK for Purview, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Authoring API Examples

Author examples in [`examples/Operations.yaml`](./examples/Operations.yaml) and
[`examples/PurviewPolicies.yaml`](./examples/PurviewPolicies.yaml). The TypeSpec emitter regenerates
the JSON files under `preview/2023-06-01-preview/examples/`; do not edit those generated
files. The request API version is implicit; use `{api-version}` where a URL embeds it.

From this directory, validate the examples and regenerate Swagger:

```sh
pnpm --package=@azure-tools/typespec-azure-examples@0.2.0 dlx tsp-examples validate . --warn-as-error
pnpm exec tsp compile .
```

---

## Configuration

### Basic Information

These are the global settings for the Purview policy API.

```yaml
openapi-type: arm
tag: package-2023-06-01-preview
```

### Tag: package-2023-06-01-preview

These settings apply only when `--tag=package-2023-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-06-01-preview'
input-file:
  - preview/2023-06-01-preview/policy.json
```
