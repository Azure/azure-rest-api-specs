# Subscriptions

> see https://aka.ms/autorest

This is the AutoRest configuration file.

## Getting Started

To build the SDK for Resource, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

## Policy-aware locations

API version `2022-12-01` supports the optional `policyAware` query parameter on
`GET /subscriptions/{subscriptionId}/locations`. Earlier API versions do not
support this option. This change does not introduce a new API version.

When `policyAware` is omitted or `false`, the existing response is unchanged.
When `true`, the response retains the same locations and existing fields and adds
`policyRestrictions` to each standard location. Restricted locations are not
removed. Extended locations, including edge zones returned with
`includeExtendedLocations=true`, are outside this evaluation scope and remain
unchanged without policy annotations.

Evaluation considers only enforced system-policy deny rules that apply at the
subscription scope and depend only on location, including applicable inherited
system policies. Non-system policies and rules requiring resource type, resource
group, or other resource data are outside this scope. An allowed result is not a
deployment authorization or a guarantee that deployment will succeed.

| Evaluation outcome | `policyRestrictions.status` | `policyRestrictions.reason` |
| --- | --- | --- |
| Completed with no applicable restriction | `Allowed` | Omitted |
| Restricted by an applicable system policy | `Restricted` | `RestrictedByPolicy` |
| Failed, timed out, unavailable, or ambiguous | `Unknown` | `EvaluationUnavailable` |

When present, `policyRestrictions` always contains a non-null `status` string.
The status is extensible: additional values may be introduced. Clients must treat
missing or unrecognized status values as unknown, not as `Allowed`.
Missing annotations do not imply permission.
A missing or incomplete evaluation must not be treated as a completed evaluation
with no restrictions. If the entire evaluation is unavailable, all standard
locations have an unknown result. If only some results cannot be determined, those
locations have an unknown result.

If location retrieval succeeds but policy evaluation is unavailable, the operation
returns HTTP 200 with the full location list and unknown annotations; it neither
filters locations nor treats them as allowed. Authentication and location-list
retrieval errors retain the existing error response behavior.

Author the contract in TypeSpec and the examples in `examples/2022-12-01`, then run
`pnpm tsp compile .` in this directory to regenerate Swagger and its examples.
Do not hand-edit generated files or modify earlier API-version contracts.

---

## Configuration

### Basic Information

These are the global settings for the Resource API.

``` yaml
title: SubscriptionClient
description: Subscription Client
openapi-type: arm
tag: package-2022-12
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-2022-12'
input-file:
  - stable/2022-12-01/subscriptions.json
```

### Tag: package-subscriptions-2022-12

These settings apply only when `--tag=package-subscriptions-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2022-12'
input-file:
- stable/2022-12-01/subscriptions.json
```

### Tag: package-subscriptions-2021-01

These settings apply only when `--tag=package-subscriptions-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2021-01'
input-file:
- stable/2021-01-01/subscriptions.json
```

### Tag: package-subscriptions-2020-01

These settings apply only when `--tag=package-subscriptions-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2020-01'
input-file:
  - stable/2020-01-01/subscriptions.json
```

### Tag: package-subscriptions-2019-11

These settings apply only when `--tag=package-subscriptions-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2019-11'
input-file:
- stable/2019-11-01/subscriptions.json
```

### Tag: package-subscriptions-2019-06

These settings apply only when `--tag=package-subscriptions-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2019-06'
input-file:
- stable/2019-06-01/subscriptions.json
```

### Tag: package-subscriptions-2018-06

These settings apply only when `--tag=package-subscriptions-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2018-06'
input-file:
- stable/2018-06-01/subscriptions.json
```

### Tag: package-subscriptions-2016-06

These settings apply only when `--tag=package-subscriptions-2016-06` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2016-06'
input-file:
- stable/2016-06-01/subscriptions.json
```

### Tag: package-subscriptions-2015-11

These settings apply only when `--tag=package-subscriptions-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-subscriptions-2015-11'
input-file:
- stable/2015-11-01/subscriptions.json
```

## Suppression

``` yaml
directive:
  - from: Subscriptions.json
    suppress: OperationsAPIImplementation
    reason: 'Duplicate Operations API causes generation issues'
```

``` yaml $(tag) == 'package-2022-12' || $(tag) == 'package-subscriptions-2022-12'
directive:
  - from: subscriptions.json
    suppress: BodyTopLevelProperties
    where: $.definitions.LocationListResult
    reason: >-
      This GET returns read-only location discovery metadata, not a CRUD resource.
      Location entries use an existing flat response shape, and policyRestrictions
      is an opt-in annotation alongside that metadata, not a resource properties bag.
      The validator reports item properties at LocationListResult, so this exception
      is limited to that discovery model in API version 2022-12-01.
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
