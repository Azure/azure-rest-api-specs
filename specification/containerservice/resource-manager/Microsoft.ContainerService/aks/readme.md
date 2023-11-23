# ContainerServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerServices (ACS/AKS/OpenShift).

The ContainerServices RPv2 consists of two similar services: ContainerServices and ManagedClusters.
Each service has its own swagger spec.

The two specs are united by running `autorest` in this directory, which will use this readme.md
file for configuration options. It will generate a single *azure-mgmt-containerservice* client
library.

---

# Getting Started

To build the SDK for ContainerServices, [install Autorest](https://aka.ms/autorest/install). Then
in this folder, run this command:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the ContainerServices API.

``` yaml
openapi-type: arm
tag: package-2023-10
```

### Tag: package-2023-10

These settings apply only when `--tag=package-2023-10` is specified on the command line.

```yaml $(tag) == 'package-2023-10'
input-file:
  - stable/2023-10-01/managedClusters.json
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - preview/2023-10-02-preview/managedClusters.json
```

### Tag: package-2023-09

These settings apply only when `--tag=package-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-2023-09'
input-file:
  - stable/2023-09-01/managedClusters.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - preview/2023-09-02-preview/managedClusters.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - stable/2023-08-01/managedClusters.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - preview/2023-08-02-preview/managedClusters.json
```

### Tag: package-2023-07

These settings apply only when `--tag=package-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-2023-07'
input-file:
  - stable/2023-07-01/managedClusters.json
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-07'
input-file:
  - preview/2023-07-02-preview/managedClusters.json
```

### Tag: package-2023-06

These settings apply only when `--tag=package-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-2023-06'
input-file:
  - stable/2023-06-01/managedClusters.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-06'
input-file:
  - preview/2023-06-02-preview/managedClusters.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
  - stable/2023-05-01/managedClusters.json
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - preview/2023-05-02-preview/managedClusters.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-2023-04'
input-file:
  - stable/2023-04-01/managedClusters.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - preview/2023-04-02-preview/managedClusters.json
```

### Tag: package-2023-03

These settings apply only when `--tag=package-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-2023-03'
input-file:
  - stable/2023-03-01/managedClusters.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - preview/2023-03-02-preview/managedClusters.json
```

### Tag: package-2023-02

These settings apply only when `--tag=package-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-2023-02'
input-file:
  - stable/2023-02-01/managedClusters.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - preview/2023-02-02-preview/managedClusters.json
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01'
input-file:
  - stable/2023-01-01/managedClusters.json
```

### Tag: package-preview-2023-01-only

These settings apply only when `--tag=package-preview-2023-01-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-01-only'
input-file:
  - preview/2023-01-02-preview/managedClusters.json
```

### Tag: package-preview-2023-01

These settings apply only when `--tag=package-preview-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-01'
input-file:
  - preview/2023-01-02-preview/managedClusters.json
  - preview/2022-09-02-preview/fleets.json
```

### Tag: package-2022-11

These settings apply only when `--tag=package-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-2022-11'
input-file:
  - stable/2022-11-01/managedClusters.json
```

### Tag: package-preview-2022-11-only

These settings apply only when `--tag=package-preview-2022-11-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11-only'
input-file:
  - preview/2022-11-02-preview/managedClusters.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - preview/2022-11-02-preview/managedClusters.json
  - preview/2022-09-02-preview/fleets.json
```

### Tag: package-preview-2022-10-only

These settings apply only when `--tag=package-preview-2022-10-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10-only'
input-file:
  - preview/2022-10-02-preview/managedClusters.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - preview/2022-10-02-preview/managedClusters.json
  - preview/2022-09-02-preview/fleets.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - stable/2022-09-01/managedClusters.json
```

### Tag: package-preview-2022-09

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-09'
input-file:
  - preview/2022-09-02-preview/managedClusters.json
  - preview/2022-09-02-preview/fleets.json
```

### Tag: package-preview-2022-08-03-only

These settings apply only when `--tag=package-preview-2022-08-03-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08-03-only'
input-file:
  - preview/2022-08-03-preview/managedClusters.json
```

### Tag: package-preview-2022-08-03

These settings apply only when `--tag=package-preview-2022-08-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08-03'
input-file:
  - preview/2022-08-03-preview/managedClusters.json
  - preview/2022-07-02-preview/fleets.json
```

### Tag: package-preview-2022-08-only

These settings apply only when `--tag=package-preview-2022-08-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08-only'
input-file:
  - preview/2022-08-02-preview/managedClusters.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - preview/2022-08-02-preview/managedClusters.json
  - preview/2022-07-02-preview/fleets.json
```

### Tag: package-2022-07

These settings apply only when `--tag=package-2022-07` is specified on the command line.

``` yaml $(tag) == 'package-2022-07'
input-file:
  - stable/2022-07-01/managedClusters.json
```

### Tag: package-preview-2022-07

These settings apply only when `--tag=package-preview-2022-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-07'
input-file:
  - preview/2022-07-02-preview/managedClusters.json
  - preview/2022-07-02-preview/fleets.json
```

### Tag: package-2022-06

These settings apply only when `--tag=package-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-2022-06'
input-file:
  - stable/2022-06-01/managedClusters.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - preview/2022-06-02-preview/managedClusters.json
  - preview/2022-06-02-preview/fleets.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - preview/2022-05-02-preview/managedClusters.json
```

### Tag: package-2022-04

These settings apply only when `--tag=package-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-2022-04'
input-file:
  - stable/2022-04-01/managedClusters.json
```

### Tag: package-preview-2022-04

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-04'
input-file:
  - preview/2022-04-02-preview/managedClusters.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - stable/2022-03-01/managedClusters.json
```

### Tag: package-preview-2022-03

These settings apply only when `--tag=package-preview-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-03'
input-file:
  - preview/2022-03-02-preview/managedClusters.json
```

### Tag: package-2022-02

These settings apply only when `--tag=package-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-2022-02'
input-file:
  - stable/2022-02-01/managedClusters.json
```

### Tag: package-preview-2022-02

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-02'
input-file:
  - preview/2022-02-02-preview/managedClusters.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - stable/2022-01-01/managedClusters.json
```

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-01'
input-file:
  - preview/2022-01-02-preview/managedClusters.json
```

### Tag: package-preview-2021-11

These settings apply only when `--tag=package-preview-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-11'
input-file:
  - preview/2021-11-01-preview/managedClusters.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
  - stable/2021-10-01/managedClusters.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - stable/2021-09-01/managedClusters.json
```

### Tag: package-2021-08

These settings apply only when `--tag=package-2021-08` is specified on the command line.

``` yaml $(tag) == 'package-2021-08'
input-file:
  - stable/2021-08-01/managedClusters.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - stable/2021-07-01/managedClusters.json
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-2021-05'
input-file:
  - stable/2021-05-01/managedClusters.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - stable/2021-03-01/managedClusters.json
```

### Tag: package-2021-02

These settings apply only when `--tag=package-2021-02` is specified on the command line.

``` yaml $(tag) == 'package-2021-02'
input-file:
  - stable/2021-02-01/managedClusters.json
```

### Tag: package-2020-12

These settings apply only when `--tag=package-2020-12` is specified on the command line.

``` yaml $(tag) == 'package-2020-12'
input-file:
  - stable/2020-12-01/managedClusters.json
```

### Tag: package-2020-11

These settings apply only when `--tag=package-2020-11` is specified on the command line.

``` yaml $(tag) == 'package-2020-11'
input-file:
  - stable/2020-11-01/managedClusters.json
```

### Tag: package-2020-09

These settings apply only when `--tag=package-2020-09` is specified on the command line.

``` yaml $(tag) == 'package-2020-09'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-09-01/managedClusters.json
```

### Tag: package-2020-07

These settings apply only when `--tag=package-2020-07` is specified on the command line.

``` yaml $(tag) == 'package-2020-07'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-07-01/managedClusters.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-06-01/managedClusters.json
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-04-01/managedClusters.json
```

### Tag: package-2020-03

These settings apply only when `--tag=package-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-2020-03'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-03-01/managedClusters.json
```

### Tag: package-2020-02

These settings apply only when `--tag=package-2020-02` is specified on the command line.

``` yaml $(tag) == 'package-2020-02'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-02-01/managedClusters.json
```

### Tag: package-2020-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-01-01/managedClusters.json
```

### Tag: package-2019-11

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2019-11-01/managedClusters.json
```

### Tag: package-2019-10-27-preview

These settings apply only when `--tag=package-2019-10-27-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-10-27-preview'
input-file:
  - preview/2019-10-27-preview/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2020-01-01/managedClusters.json
```

### Tag: package-2019-09-30-preview

These settings apply only when `--tag=package-2019-09-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-09-30-preview'
input-file:
  - preview/2019-09-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/managedClusters.json
  - stable/2019-08-01/location.json
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2019-10-01/managedClusters.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-08-01/location.json
  - stable/2019-08-01/managedClusters.json
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

``` yaml $(tag) == 'package-2019-06'
input-file:
  - stable/2019-04-30/openShiftManagedClusters.json
  - stable/2017-07-01/containerService.json
  - stable/2019-06-01/location.json
  - stable/2019-06-01/managedClusters.json
```

### Tag: package-2019-04

These settings apply only when `--tag=package-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-2019-04'
input-file:
- stable/2019-04-30/openShiftManagedClusters.json
- stable/2017-07-01/containerService.json
- stable/2019-04-01/managedClusters.json
- stable/2019-04-01/location.json
```

### Tag: package-2019-02

These settings apply only when `--tag=package-2019-02` is specified on the command line.

``` yaml $(tag) == 'package-2019-02'
input-file:
- preview/2018-09-30-preview/openShiftManagedClusters.json
- stable/2017-07-01/containerService.json
- stable/2019-02-01/managedClusters.json
- stable/2017-09-30/location.json
```

### Tag: package-2018-08-preview

These settings apply only when `--tag=package-2018-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-08-preview'
input-file:
- preview/2018-09-30-preview/openShiftManagedClusters.json
- stable/2017-07-01/containerService.json
- preview/2018-08-01-preview/managedClusters.json
- stable/2017-09-30/location.json
```

### Tag: package-2018-09-30-preview

These settings apply only when `--tag=package-2018-09-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-30-preview'
input-file:
- preview/2018-09-30-preview/openShiftManagedClusters.json
- stable/2017-07-01/containerService.json
- stable/2018-03-31/managedClusters.json
- stable/2017-09-30/location.json
```

### Tag: package-2018-03

These settings apply only when `--tag=package-2018-03` is specified on the command line.

``` yaml $(tag) == 'package-2018-03'
input-file:
- stable/2017-07-01/containerService.json
- stable/2018-03-31/managedClusters.json
- stable/2017-09-30/location.json
```

### Tag: package-2017-09

These settings apply only when `--tag=package-2017-09` is specified on the command line.

``` yaml $(tag) == 'package-2017-09'
input-file:
- stable/2017-07-01/containerService.json
- stable/2017-08-31/managedClusters.json
- stable/2017-09-30/location.json
```

### Tag: package-2017-08

These settings apply only when `--tag=package-2017-08` is specified on the command line.

``` yaml $(tag) == 'package-2017-08'
input-file:
- stable/2017-07-01/containerService.json
- stable/2017-08-31/managedClusters.json
```

### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- stable/2017-07-01/containerService.json

```

### Tag: package-2019-09-preview-only

These settings apply only when `--tag=package-2019-09-preview-only` is specified on the command line.

This is a special tag used only by python sdk generation. To avoid introducing breaking changes in compatibility to the
v2019_09_30_preview namespace of python SDK, DO NOT MODIFY THIS TAG.

``` yaml $(tag) == 'package-2019-09-preview-only'
input-file:
- preview/2019-09-30/openShiftManagedClusters.json
```

### Tag: package-2017-07-only-extended

These settings apply only when `--tag=package-2017-07-only-extended` is specified on the command line.

This is a special tag used only by python sdk generation. To avoid introducing breaking changes in compatibility to the
v2017_07_01 namespace of python SDK, DO NOT MODIFY THIS TAG.

``` yaml $(tag) == 'package-2017-07-only-extended'
input-file:
- stable/2017-07-01/containerService.json
- stable/2019-04-01/location.json
```

### Tag: package-2020-09-01-only

These settings apply only when `--tag=package-2020-09-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-09-01-only'
input-file:
- stable/2020-09-01/managedClusters.json
```

### Tag: package-2020-07-01-only

These settings apply only when `--tag=package-2020-07-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-01-only'
input-file:
- stable/2020-07-01/managedClusters.json
```

### Tag: package-2020-06-01-only

These settings apply only when `--tag=package-2020-06-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-01-only'
input-file:
- stable/2020-06-01/managedClusters.json
```

### Tag: package-2020-04-01-only

These settings apply only when `--tag=package-2020-04-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-04-01-only'
input-file:
- stable/2020-04-01/managedClusters.json
```

### Tag: package-2020-03-01-only

These settings apply only when `--tag=package-2020-03-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01-only'
input-file:
- stable/2020-03-01/managedClusters.json
```

### Tag: package-2020-02-01-only

These settings apply only when `--tag=package-2020-02-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-01-only'
input-file:
- stable/2020-02-01/managedClusters.json
```

### Tag: package-2020-01-01-only

These settings apply only when `--tag=package-2020-01-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-01-01-only'
input-file:
- stable/2020-01-01/managedClusters.json
```

### Tag: package-2019-11-01-only

These settings apply only when `--tag=package-2019-11-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01-only'
input-file:
- stable/2019-11-01/managedClusters.json
```

### Tag: package-2019-10-27-preview-only

These settings apply only when `--tag=package-2019-10-27-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-10-27-preview-only'
input-file:
- preview/2019-10-27-preview/openShiftManagedClusters.json
```

### Tag: package-2019-10-01-only

These settings apply only when `--tag=package-2019-10-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-10-01-only'
input-file:
- stable/2019-10-01/managedClusters.json
```

### Tag: package-2019-08-01-only

These settings apply only when `--tag=package-2019-08-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-08-01-only'
input-file:
- stable/2019-08-01/managedClusters.json
```

### Tag: package-2019-06-01-only

These settings apply only when `--tag=package-2019-06-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-01-only'
input-file:
- stable/2019-06-01/managedClusters.json
```

### Tag: package-2019-04-30-only

These settings apply only when `--tag=package-2019-04-30-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-04-30-only'
input-file:
- stable/2019-04-30/openShiftManagedClusters.json
```

### Tag: package-2019-04-01-only

These settings apply only when `--tag=package-2019-04-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-04-01-only'
input-file:
- stable/2019-04-01/managedClusters.json
- stable/2019-04-01/location.json
```

### Tag: package-2019-02-only

These settings apply only when `--tag=package-2019-02-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-02-only'
input-file:
- stable/2019-02-01/managedClusters.json
```

### Tag: package-2018-09-preview-only

These settings apply only when `--tag=package-2018-09-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-preview-only'
input-file:
- preview/2018-09-30-preview/openShiftManagedClusters.json
```

### Tag: package-2018-08-preview-only

These settings apply only when `--tag=package-2018-08-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-08-preview-only'
input-file:
- preview/2018-08-01-preview/managedClusters.json
```

### Tag: package-2018-03-only

These settings apply only when `--tag=package-2018-03-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-03-only'
input-file:
- stable/2018-03-31/managedClusters.json
```

### Tag: package-2017-09-only

These settings apply only when `--tag=package-2017-09-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-09-only'
input-file:
- stable/2017-09-30/location.json
```

### Tag: package-2017-08-only

These settings apply only when `--tag=package-2017-08-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-08-only'
input-file:
- stable/2017-08-31/managedClusters.json
```

### Tag: package-2017-01-only

These settings apply only when `--tag=package-2017-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2017-01-only'
input-file:
- stable/2017-01-31/containerService.json
```

### Tag: package-2016-09-only

These settings apply only when `--tag=package-2016-09-only` is specified on the command line.

``` yaml $(tag) == 'package-2016-09-only'
input-file:
- stable/2016-09-30/containerService.json
```

### Tag: package-2016-03-only

These settings apply only when `--tag=package-2016-03-only` is specified on the command line.

``` yaml $(tag) == 'package-2016-03-only'
input-file:
- stable/2016-03-30/containerService.json
```

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
- stable/2020-11-01/managedClusters.json
- stable/2019-04-01/location.json
- stable/2017-07-01/containerService.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_container_service']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ContainerService
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/containerservice/Microsoft.Azure.Management.ContainerService/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: managedClusters.json
    reason: Name change of "enableRBAC" property would break compatibility
  - suppress: TrackedResourcePatchOperation
    from: containerService.json
    reason: ACS service is deprecated so a PATCH endpoint won't be implemented
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: managedClusters.json
    where: $.definitions.ManagedClusterSecurityProfile.properties.customCATrustCertificates      
    reason: customCATrustCertificates contains a widely used acronym, no camel case restriction needed.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: managedClusters.json
    where: $.definitions.ManagedClusterOIDCIssuerProfile.properties.issuerURL
    reason: For managedCluster.properties.oidcIssuerProfile.issuerURL, already used in preview API
```
