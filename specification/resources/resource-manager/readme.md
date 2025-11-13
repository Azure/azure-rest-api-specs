# Resource

> see https://aka.ms/autorest

This is the AutoRest configuration file for Resource.

---

## Getting Started

To build the SDK for Resource, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Resource API.

``` yaml
openapi-type: arm
tag: profile-hybrid-2019-03-01
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Authorization/locks/stable/2016-09-01/locks.json
- Microsoft.Authorization/policy/stable/2016-12-01/policyDefinitions.json
- Microsoft.Authorization/policy/stable/2016-12-01/policyAssignments.json
- Microsoft.Resources/subscriptions/stable/2016-06-01/subscriptions.json
- Microsoft.Resources/resources/stable/2018-05-01/resources.json

override-info:
  title: PolicyClient
```
