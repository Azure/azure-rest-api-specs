# Anyscale.Platform

> see https://aka.ms/autorest

This is the AutoRest configuration file for Anyscale.Platform.

## Getting Started

To build the SDK for Anyscale.Platform, simply [Install AutoRest](https://aka.ms/autorest/install)
 and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

## Configuration

### Basic Information

These are the global settings for the Anyscale.Platform API.

``` yaml
openapi-type: arm
tag: package-2026-09-01
```

### Tag: package-2026-09-01

These settings apply only when `--tag=package-2026-09-01` is specified on the command line.

``` yaml $(tag) == 'package-2026-09-01'
input-file:
- stable/2026-09-01/anyscale.json
directive:
	- suppress: AvoidAdditionalProperties
		from: anyscale.json
		where:
			- $.definitions.NodeType.properties.labels
			- $.definitions.NodeType.properties.requiredLabels
			- $.definitions.LogicalResources.properties.customResources
			- $.definitions.JobConfig.properties.envVars
			- $.definitions.ServiceDeploymentConfig.properties.envVars
			- $.definitions.NodeType.properties.flags
			- $.definitions.ComputeConfigSpecOption.properties.flags
		reason: Intentional dynamic-key maps required by the Anyscale control-plane contract; value types are production-validated (labels/requiredLabels/envVars string, customResources int, flags heterogeneous).
```

## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
