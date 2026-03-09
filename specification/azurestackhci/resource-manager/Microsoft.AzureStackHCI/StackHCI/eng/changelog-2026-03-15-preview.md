# Changelog — API version `2026-03-15-preview` (Private Preview additions)

## ClusterProperties

### New fields

| Field | Type | Access | Description |
|---|---|---|---|
| `storageType` | `StorageType` | Read-only | Indicates whether the cluster storage is `S2D`, `SAN`, or `SANS2D`. |

---

## Storage

### New fields

| Field | Type | Description |
|---|---|---|
| `storageType` | `StorageType` | Storage type for the cluster. |
| `s2d` | `StorageS2dConfig` | S2D configuration. Applicable when `storageType` is `S2D` or `SANS2D`. |
| `san` | `StorageSanConfig` | SAN configuration. Applicable when `storageType` is `SAN` or `SANS2D`. |
| `disks` | `Disk[]` | List of storage disks. |

---

## DeploymentSettingHostNetwork

### New fields

| Field | Type | Description |
|---|---|---|
| `sanNetworks` | `SanNetworks[]` | SAN network configuration for host network. Applicable when `storageType` is `SAN` or `SANS2D`. |

---

## HciStorageProfile

### New fields

| Field | Type | Access | Description |
|---|---|---|---|
| `disks` | `Disk[]` | Read-only | List of storage disks on the device. |

---

## New models

### `Disk`

Represents a storage disk on the device.

| Field | Type | Access | Description |
|---|---|---|---|
| `id` | `string` | Read-only | The unique identifier of the disk. Required. |
| `size` | `string` | Read-only | The size of the disk. |
| `type` | `string` | Read-only | The type of the disk. |

---

### `StorageType`

Union of allowed storage types.

| Value | Description |
|---|---|
| `S2D` | Storage Spaces Direct. |
| `SAN` | Storage Area Network. |
| `SANS2D` | Combined SAN and S2D. |

---

### `VolumeType`

Union of volume provisioning types (used in `StorageS2dConfig`).

| Value | Description |
|---|---|
| `Fixed` | Fixed-size volume. |
| `ThinProvisioned` | Thin-provisioned volume. |

---

### `OverprovisioningRatio`

Union of overprovisioning ratio values for S2D storage (used in `StorageS2dConfig`).

| Value |
|---|
| `"0"` |
| `"1"` |
| `"2"` |

---

### `StorageS2dConfig`

S2D (Storage Spaces Direct) configuration.

| Field | Type | Description |
|---|---|---|
| `volumeType` | `VolumeType` | Volume provisioning type. |
| `overprovisioningRatio` | `OverprovisioningRatio` | Overprovisioning ratio for S2D storage. |

---

### `StorageSanConfig`

SAN (Storage Area Network) configuration.

| Field | Type | Description |
|---|---|---|
| `infraVolLunId` | `string` | Infrastructure volume LUN ID. |
| `infraPerfLunId` | `string` | Infrastructure performance LUN ID. |

---

### `SanNetworks`

Top-level SAN network configuration for host network.

| Field | Type | Description |
|---|---|---|
| `clusterNetworkConfig` | `SanClusterNetworkConfig` | Cluster (CSV/LiveMig) network configuration. |

---

### `SanClusterNetworkConfig`

Cluster network configuration for SAN deployments (CSV/LiveMig traffic).

| Field | Type | Description |
|---|---|---|
| `adapterProperties` | `SanAdapterProperties` | QoS and adapter property overrides. |
| `adapterIPConfig` | `SanAdapterIPConfig[]` | Per-adapter IP configuration. |

---

### `SanAdapterProperties`

QoS and adapter overrides for SAN cluster network traffic.

| Field | Type | Description |
|---|---|---|
| `priorityValue8021ActionCluster` | `int32` | 802.1p priority value for cluster traffic. |
| `priorityValue8021ActionSmb` | `int32` | 802.1p priority value for SMB traffic. |
| `bandwidthPercentageSmb` | `int32` | SMB bandwidth percentage (1–97). |
| `jumboPacket` | `int32` | Jumbo frame size in bytes. |

---

### `SanAdapterIPConfig`

Per-adapter IP configuration for SAN cluster network.

| Field | Type | Description |
|---|---|---|
| `name` | `string` | Logical name of the adapter IP configuration. |
| `networkAdapterName` | `string` | Physical NIC name. |
| `vlanId` | `int32` | VLAN ID. |
| `addressPrefix` | `string` | IP address prefix in CIDR notation. |

---

## New examples

| File | Scenario |
|---|---|
| `examples/2026-03-15-preview/PutDeploymentSettings_StorageS2D.json` | DeploymentSettings PUT with S2D storage config. |
| `examples/2026-03-15-preview/PutDeploymentSettings_StorageSAN.json` | DeploymentSettings PUT with SAN storage config including `sanNetworks`. |

---

## New resource: ClusterVolume

Read-only child resource of `Cluster` for surfacing cluster storage volumes.

### Operations

| Operation | Description |
|---|---|
| `GET` | Get a specific cluster volume |
| `LIST` | List all cluster volumes on a cluster |

### `ClusterVolumeProperties`

| Field | Type | Access | Description |
|---|---|---|---|
| `reportedProperties` | `ClusterVolumeReportedProperties` | Read-only | Actual state of the cluster volume as reported by the cluster. |
| `provisioningState` | `ProvisioningState` | Read-only | Standard ARM provisioning state. |

> **Note:** `clusterVolumeConfiguration` is reserved for future use (TODO).

### `ClusterVolumeReportedProperties`

| Field | Type | Access | Description |
|---|---|---|---|
| `id` | `string` | Read-only | Volume GUID. |
| `name` | `string` | Read-only | User-visible volume label. |
| `path` | `string` | Read-only | Cluster volume mount path (CSV or device path). |
| `clusterResourceId` | `string` | Read-only | Cluster resource GUID for PDR-backed volumes. |
| `statusCategory` | `ClusterVolumeStatusCategory` | Read-only | Health rollup (Healthy, Warning, Unhealthy, Others). |
| `status` | `int32[]` | Read-only | Operational status codes. |
| `size` | `int64` | Read-only | Total size in bytes. |
| `sizeRemaining` | `int64` | Read-only | Free space in bytes. |
| `resiliency` | `ClusterVolumeResiliency` | Read-only | Resiliency type (Simple, TwoWayMirror, etc.). |
| `media` | `ClusterVolumeMediaType` | Read-only | Media type (Disk, SSD, SCM, etc.). |
| `faultDomainAwareness` | `ClusterVolumeFaultDomainAwareness` | Read-only | Fault domain level (Drive, Server, Rack, etc.). |
| `provisioningType` | `ClusterVolumeProvisioningType` | Read-only | Provisioning mode (Thin, Fixed). |
| `storagePoolName` | `string` | Read-only | Containing storage pool name. |
| `server` | `string` | Read-only | Current owner node. |
| `isDedupEnabled` | `boolean` | Read-only | Data deduplication enabled. |
| `isEncrypted` | `boolean` | Read-only | BitLocker encryption enabled. |
| `isIntegrityEnabled` | `boolean` | Read-only | ReFS integrity streams enabled. |

### New unions

| Union | Values |
|---|---|
| `ClusterVolumeStatusCategory` | `Healthy`, `Warning`, `Unhealthy`, `Others` |
| `ClusterVolumeResiliency` | `Unknown`, `Simple`, `SingleParity`, `DualParity`, `TwoWayMirror`, `ThreeWayMirror`, `MRT` |
| `ClusterVolumeMediaType` | `Unknown`, `Disk`, `SSD`, `Journal`, `SCM` |
| `ClusterVolumeFaultDomainAwareness` | `Unknown`, `Drive`, `Enclosure`, `Server`, `Chassis`, `Rack` |
| `ClusterVolumeProvisioningType` | `Thin`, `Fixed` |
