# ContainerClusters

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerClusters.

---

## Getting Started

To build the SDK for ContainerClusters, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for ContainerClusters.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2027-01-01
```

### Suppression

```yaml
directive:
  - suppress: AvoidAdditionalProperties
    reason: Properties in the GCP definition represent user-defined tags, labels and free-form metadata.
    where:
      - $.definitions.ClusterProperties.properties.gcpTags
      - $.definitions.AutoprovisioningNodePoolDefaults.properties.resourceLabels
      - $.definitions.GcpContainerClusterProperties.properties.resourceLabels
      - $.definitions.LinuxNodeConfig.properties.sysctls
      - $.definitions.MaintenanceWindow.properties.maintenanceExclusions
      - $.definitions.NodeConfig.properties.labels
      - $.definitions.NodeConfig.properties.metadata
      - $.definitions.NodeConfig.properties.resourceLabels
      - $.definitions.OperationError.properties.details
      - $.definitions.ResourceManagerTags.properties.tags

  - suppress: XMSSecretInResponse
    reason:
      False positive. `bootDiskKmsKey` is not a secret. It is the relative resource name of a
      Cloud KMS key used for boot disk encryption, in the form
      `projects/<project>/locations/<location>/keyRings/<ring>/cryptoKeys/<key>`. It is an
      identifier only and contains no key material or credentials.
    where:
      - $.definitions.AutoprovisioningNodePoolDefaults.properties.bootDiskKmsKey
      - $.definitions.NodeConfig.properties.bootDiskKmsKey
```

### Tag: package-2027-01-01

These settings apply only when `--tag=package-2027-01-01` is specified on the command line.

```yaml $(tag) == 'package-2027-01-01'
input-file:
  - stable/2027-01-01/containerClusters.json
```
