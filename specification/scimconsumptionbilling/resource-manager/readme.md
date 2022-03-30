# Datadog

> see https://aka.ms/autorest

This is the AutoRest configuration file for Consumption Billing Resource Provider.


## Getting Started
To build the SDK for the Consumption Billing RP, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information
These are the global settings for the Consumption Billing  RP.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2020-06-10
```

### Tag: package-2022-03-07-preview

These settings apply only when `--tag=package-2022-04-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-04-07-preview'
input-file:
- Microsoft.ScimConsumptionBilling/preview/2022-04-07-preview/consumptionbilling.json