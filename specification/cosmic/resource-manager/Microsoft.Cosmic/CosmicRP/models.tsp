import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

@doc("Microsoft.Cosmic Resource Provider Management API.")
namespace Microsoft.Cosmic;

// ─── Cosmic Ring Definition ─────────────────────────────────────────────

@doc("Cosmic Rings.")
union CosmicRing {
  @doc("Plat ring")
  Plat: "plat",

  @doc("Dev ring")
  Dev: "dev",

  @doc("Rnr ring")
  Rnr: "rnr",

  @doc("Tdf ring")
  Tdf: "tdf",

  @doc("Infra ring")
  Infra: "infra",

  @doc("Test ring")
  Test: "test",

  @doc("SDF ring")
  Sdf: "sdf",

  @doc("MSIT ring")
  Msit: "msit",

  @doc("Prod ring")
  Prod: "prod",

  @doc("Gallatin ring")
  Gallatin: "gallatin",

  @doc("Bleu ring")
  Bleu: "bleu",

  @doc("Delos ring")
  Delos: "delos",

  @doc("GCC ring")
  Gcc: "gcc",

  @doc("GCCH ring")
  Gcch: "gcch",

  @doc("DOD ring")
  Dod: "dod",

  @doc("Ag08 ring")
  Ag08: "ag08",

  @doc("Ag09 ring")
  Ag09: "ag09",

  string,
}

// ─── Provisioning state ─────────────────────────────────────────────

@doc("The provisioning state of a Cosmic resource.")
union CosmicProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource is being updated.")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource creation request has been accepted.")
  Accepted: "Accepted",

  string,
}

// ─── Environment enums ───────────────────────────────────────────────

@doc("The operating system type for the compute nodes.")
union OsType {
  @doc("Linux operating system.")
  Linux: "Linux",

  @doc("Windows operating system.")
  Windows: "Windows",

  string,
}

@doc("IP Version")
union IpVersion {
  @doc("Version IPv4")
  IPV4: "IPv4",

  @doc("Version IPv6")
  IPV6: "IPv6",

  string,
}

@doc("The GPU driver type.")
union GpuDriverType {
  @doc("CUDA driver for compute workloads.")
  CUDA: "CUDA",

  @doc("GRID driver for visualization workloads.")
  GRID: "GRID",

  string,
}

@doc("The migration state of a namespace instance.")
union MigrationState {
  @doc("Instance spec and cluster spec are mismatched; migration is required but has not started.")
  NeedsMigration: "NeedsMigration",

  @doc("The instance is currently being migrated.")
  InMigration: "InMigration",

  @doc("The instance is correctly placed; no migration is required.")
  NoMigrationNeeded: "NoMigrationNeeded",

  string,
}

@doc("The realization state of an environment resource.")
union RealizationState {
  @doc("Realization has been accepted.")
  Accepted: "Accepted",

  @doc("Realization is in progress.")
  InProgress: "InProgress",

  @doc("Realization succeeded.")
  Succeeded: "Succeeded",

  @doc("Realization failed.")
  Failed: "Failed",

  @doc("Realization was canceled.")
  Canceled: "Canceled",

  @doc("Realization partially succeeded.")
  PartiallySucceeded: "PartiallySucceeded",

  string,
}

@doc("The health state of an environment resource.")
union HealthState {
  @doc("The environment is healthy.")
  Healthy: "Healthy",

  @doc("The environment is unhealthy.")
  Unhealthy: "Unhealthy",

  @doc("The health state is unknown.")
  Unknown: "Unknown",

  string,
}

// ─── Topology models ────────────────────────────────────────────────

@doc("Optional per-location topology declarations including networking and partition identity.")
model Topology {
  @doc("Per-location topology declarations keyed by canonical Azure region name.")
  @identifiers(#["name"])
  locations?: TopologyLocation[];
}

@doc("Per-location topology configuration including networking and optional partition declarations.")
model TopologyLocation {
  @doc("Canonical Azure region name.")
  name: string;

  @doc("Optional SNAT ports to allocate per node.")
  snatPortsPerNode?: int32;

  @doc("BYOIP configuration for ingress traffic.")
  @identifiers(#["ipTagType", "ipTagValue"])
  ingressPublicIps?: IngressPublicIp[];

  @doc("BYOIP configuration for egress traffic.")
  egressPublicIps?: EgressPublicIps;

  @doc("Optional declared partition set for this location.")
  @identifiers(#["name"])
  partitions?: TopologyPartition[];
}

@doc("Declared partition identity for a location.")
model TopologyPartition {
  @doc("The partition name.")
  name: string;
}

// ─── Capacity models ────────────────────────────────────────────────

@doc("Capacity configuration for the environment.")
model CapacityPolicy {
  @doc("Per-location desired capacity keyed by canonical Azure region name.")
  @identifiers(#["name"])
  locations?: LocationCapacity[];
}

@doc("Per-location desired capacity.")
model LocationCapacity {
  @doc("Canonical Azure region name.")
  name: string;

  @doc("Total desired instance count in this location.")
  totalInstanceCount?: int32;

  @doc("Optional breakdown of capacity by partition key.")
  @identifiers(#["name"])
  partitions?: PartitionCapacity[];
}

@doc("Explicit capacity configuration for a specific partition.")
model PartitionCapacity {
  @doc("The partition name.")
  name: string;

  @doc("The number of instances to realize for this partition.")
  instanceCount: int32;
}

// ─── Resource policy models ─────────────────────────────────────────

@doc("Resource policy configuration with layered ring/region/partition overrides.")
model ResourcePolicy {
  @doc("Default resource policy for the ring.")
  ringDefault?: RingDefaultPolicy;

  @doc("Per-region resource policy overrides keyed by canonical location.")
  @identifiers(#["name"])
  regionOverrides?: RegionOverride[];
}

@doc("Ring-scoped default resource policy.")
model RingDefaultPolicy {
  @doc("Per-service pod resource specifications.")
  @identifiers(#[])
  podResources?: PodResource[];

  @doc("The operating system type.")
  os?: OsType;

  @doc("The IP version (IPv4 or IPv6).")
  ipVersion?: IpVersion;
}

@doc("Region-scoped policy overrides.")
model RegionOverride {
  @doc("Canonical Azure region name.")
  name: string;

  @doc("Region-level default policy.")
  regionDefault?: RegionDefaultPolicy;

  @doc("Partition-scoped policy overrides keyed by partition name.")
  @identifiers(#["name"])
  partitions?: PartitionOverride[];
}

@doc("Region-level default resource policy.")
model RegionDefaultPolicy {
  @doc("The IP version override for this region.")
  ipVersion?: IpVersion;
}

@doc("Partition-scoped policy overrides.")
model PartitionOverride {
  @doc("The partition name.")
  name: string;

  @doc("Partition-level default policy.")
  partitionDefault?: PartitionDefaultPolicy;

  @doc("Migration-only per-instance overrides.")
  @identifiers(#["instanceId"])
  instanceOverrides?: InstanceOverride[];
}

@doc("Partition-level default resource policy.")
model PartitionDefaultPolicy {
  @doc("The operating system type override.")
  os?: OsType;

  @doc("Per-service pod resource specifications.")
  @identifiers(#[])
  podResources?: PodResource[];
}

@doc("Migration-only per-instance resource override.")
model InstanceOverride {
  @doc("Opaque RP instance identifier (GUID).")
  instanceId: string;

  @doc("Optional per-instance quota override.")
  instanceQuota?: InstanceQuota;
}

@doc("Per-instance quota override shape (migration-only).")
model InstanceQuota {
  @doc("The Azure VM family.")
  vmFamily?: string;

  @doc("Per-service pod resource specifications.")
  @identifiers(#[])
  podResources?: PodResource[];
}

// ─── Pod resource models ─────────────────────────────────────────────

@doc("Pod resource envelope.")
model PodResource {
  @doc("CPU cores requested per pod (e.g. '0.5', '2').")
  cores?: string;

  @doc("Memory requested per pod (e.g. '512Mi', '2Gi').")
  memory?: string;

  @doc("CPU cores limit per pod. If unset, defaults to approximately 2x the request.")
  coresLimit?: string;

  @doc("Memory limit per pod. If unset, defaults to approximately 2x the request.")
  memoryLimit?: string;

  @doc("Number of replicas per cluster.")
  replicas?: int32;

  @doc("Percentage of replicas considered during rolling updates.")
  rollingUpdateReplicaPercentage?: int32;
}

// ─── Environment read-only status models ─────────────────────────────

@doc("Status of the environment.")
model EnvironmentStatus {
  @doc("The overall realization state.")
  realizationState?: RealizationState;

  @doc("Per-region realization details.")
  @identifiers(#["id"])
  realizations?: Realization[];
}

@doc("Realization details for a specific region.")
model Realization {
  @doc("Stable RP-generated identifier for diagnostics.")
  id: string;

  @doc("Canonical Azure region name.")
  region: Azure.Core.azureLocation;

  @doc("Realization-specific state.")
  state?: RealizationState;

  @doc("Partition realization details.")
  @identifiers(#["name"])
  partitions?: Partition[];

  @doc("Instance realization details.")
  @identifiers(#["id"])
  instances?: Instance[];

  @doc("Effective networking configuration applied by the RP for this region.")
  networking?: TopologyLocation;
}

@doc("Partition label present in this realization.")
model Partition {
  @doc("The partition name.")
  name: string;
}

@doc("Operational instance within a realization.")
model Instance {
  @doc("The instance identifier.")
  id: string;

  @doc("The partition this instance belongs to.")
  partition: string;

  @doc("Legacy routing partition metadata preserved for migration parity.")
  routingPartition?: string;

  @doc("The ARM resource ID of the cluster backing this instance.")
  clusterResourceId?: Azure.Core.armResourceIdentifier;
}

// ─── Networking models ───────────────────────────────────────────────

@doc("Ingress public IP configuration using BYOIP.")
model IngressPublicIp {
  @doc("The IP tag type for ingress.")
  ipTagType: string;

  @doc("The IP tag value for ingress.")
  ipTagValue: string;

  @doc("Names associated with this ingress IP configuration.")
  names?: string[];

  @doc("The IP version (IPv4 or IPv6). Defaults to IPv4.")
  ipVersion?: IpVersion;
}

@doc("Egress public IP configuration using BYOIP.")
model EgressPublicIps {
  @doc("The IP tag type for egress.")
  ipTagType?: string;

  @doc("The IP tag value for egress.")
  ipTagValue?: string;

  @doc("The IP capacity for egress.")
  ipCapacity?: string;

  @doc("The IP version (IPv4 or IPv6). Defaults to IPv4.")
  ipVersion?: IpVersion;
}
