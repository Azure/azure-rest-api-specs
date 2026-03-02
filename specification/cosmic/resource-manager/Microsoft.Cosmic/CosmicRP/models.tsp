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
  @doc("Realization is in progress.")
  InProgress: "InProgress",

  @doc("Realization succeeded.")
  Succeeded: "Succeeded",

  @doc("Realization failed.")
  Failed: "Failed",

  @doc("Realization is pending.")
  Pending: "Pending",

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

// ─── Environment writable intent models ──────────────────────────────

@doc("Topology configuration for the environment.")
model TopologyConfiguration {
  @doc("The partition name.")
  partitionName?: string;

  @doc("The Azure regions where instances should be placed (e.g. ['eastus', 'westus']).")
  regions?: Azure.Core.azureLocation[];
}

@doc("Capacity configuration for the environment.")
model CapacityConfiguration {
  @doc("Total number of instances across all partitions.")
  instanceCount?: int32;

  @doc("Per-partition capacity overrides within this region.")
  @identifiers(#["partitionName"])
  partitionOverrides?: CapacityPartitionOverride[];
}

@doc("Capacity override for a specific partition within a region.")
model CapacityPartitionOverride {
  @doc("The partition name.")
  partitionName?: string;

  @doc("Number of instances in this partition.")
  instanceCount?: int32;

  @doc("Per-region capacity overrides.")
  @identifiers(#["region"])
  regionOverrides?: CapacityRegionOverride[];
}

@doc("Capacity override for a specific region.")
model CapacityRegionOverride {
  @doc("The Azure region name.")
  region: Azure.Core.azureLocation;

  @doc("Total number of instances in this region.")
  instanceCount: int32;
}

@doc("Resource policy configuration for the environment.")
model ResourcePolicyConfiguration {
  @doc("Default resource policy for all rings.")
  resourcePolicy?: ResourcePolicy;

  @doc("Per-region resource policy overrides.")
  @identifiers(#["region"])
  regionOverrides?: RegionalResourcePolicy[];
}

@doc("Default resource policy settings.")
model ResourcePolicy {
  @doc("The default Azure VM family (e.g. 'Standard_D', 'Standard_E').")
  vmFamily?: string;

  @doc("The operating system type (e.g. Linux, Windows).")
  osType?: OsType;

  @doc("The number of GPUs requested.")
  gpus?: float64;

  @doc("The GPU driver type (e.g. CUDA, GRID).")
  gpuDriverType?: GpuDriverType;

  @doc("Per-service pod resource specifications.")
  @identifiers(#["serviceName"])
  podResources?: PodResourceSpec[];
}

@doc("Resource policy override for a specific region.")
model RegionalResourcePolicy {
  @doc("The Azure region name.")
  region?: Azure.Core.azureLocation;

  @doc("Default resource policy for all rings.")
  resourcePolicy?: ResourcePolicy;
}

// ─── Pod resource models ─────────────────────────────────────────────

@doc("Resource specification for a single service pod.")
model PodResourceSpec {
  @doc("The name of the service.")
  serviceName?: string;

  @doc("Number of replicas per cluster.")
  replicas?: int32;

  @doc("CPU cores requested per pod (e.g. '0.5', '2').")
  cores?: string;

  @doc("Memory requested per pod (e.g. '512Mi', '2Gi').")
  memory?: string;

  @doc("CPU cores limit per pod. If unset, defaults to approximately 2x the request.")
  coresLimit?: string;

  @doc("Memory limit per pod. If unset, defaults to approximately 2x the request.")
  memoryLimit?: string;

  @doc("Percentage of replicas considered during rolling updates (default: 10).")
  rollingUpdateReplicaPercentage?: int32;

  @doc("Number of GPUs per pod.")
  gpus?: string;
}

// ─── Environment read-only status models ─────────────────────────────

@doc("Status of the environment.")
model EnvironmentStatus {
  @doc("The overall realization state.")
  realizationState?: RealizationState;

  @doc("Per-region realization details.")
  @identifiers(#["realizationId"])
  realizations?: RegionRealization[];

  @doc("Status conditions reporting errors or important state transitions.")
  @identifiers(#["type"])
  conditions?: StatusCondition[];

  @doc("The expected completion time for an in-progress operation.")
  expectedCompletionTime?: utcDateTime;

  @doc("A human-readable description of the current environment status.")
  statusDescription?: string;
}

@doc("Realization details for a specific region.")
model RegionRealization {
  @doc("The Azure region name.")
  region: Azure.Core.azureLocation;

  @doc("The realization identifier.")
  realizationId: string;

  @doc("The provisioning state of this realization.")
  provisioningState?: ResourceProvisioningState;

  @doc("The health state of this realization.")
  healthState?: HealthState;

  @doc("Partition realization details.")
  @identifiers(#["name"])
  partitions?: PartitionRealization[];

  @doc("Instance realization details.")
  @identifiers(#["instanceId"])
  instances?: InstanceRealization[];
}

@doc("Realization details for a specific partition.")
model PartitionRealization {
  @doc("The partition name.")
  name: string;

  @doc("The realization state of this partition.")
  realizationState?: RealizationState;
}

@doc("Realization details for a specific instance.")
model InstanceRealization {
  @doc("The instance identifier.")
  instanceId: string;

  @doc("The partition this instance belongs to.")
  partition: string;

  @doc("The ARM resource ID of the cluster backing this instance.")
  clusterResourceId?: Azure.Core.armResourceIdentifier;

  @doc("The provisioning state of this instance.")
  provisioningState?: ResourceProvisioningState;

  @doc("The current migration state of this instance.")
  migrationState?: MigrationState;
}

@doc("A condition reporting detailed status information.")
model StatusCondition {
  @doc("The type of condition (e.g. InMigration, PlacementAbandoned).")
  type: string;

  @doc("The status of the condition: True, False, or Unknown.")
  conditionStatus?: string;

  @doc("A one-word CamelCase reason for the condition's last transition.")
  reason?: string;

  @doc("A human-readable message with details about the last transition.")
  message?: string;

  @doc("The last time an update was received for this condition.")
  lastHeartbeatTime?: utcDateTime;

  @doc("The last time this condition transitioned from one status to another.")
  lastTransitionTime?: utcDateTime;
}

// ─── Networking models ───────────────────────────────────────────────

@doc("Networking configuration for the environment.")
model NetworkingConfiguration {
  @doc("BYOIP (Bring Your Own IP) tags for ingress traffic.")
  @identifiers(#["ipTagType", "ipTagValue"])
  ingressPublicIps?: IngressPublicIpConfiguration[];

  @doc("BYOIP (Bring Your Own IP) configuration for egress traffic.")
  egressPublicIps?: EgressPublicIpConfiguration;

  @doc("Optional SNAT ports to allocate per node. Empty or unset means not specified.")
  snatPortsPerNode?: int32;

  @doc("Instance-level public IP configuration.")
  instanceLevelPublicIp?: InstanceLevelPublicIpConfiguration;
}

@doc("Ingress public IP configuration using BYOIP.")
model IngressPublicIpConfiguration {
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
model EgressPublicIpConfiguration {
  @doc("The IP tag type for egress.")
  ipTagType?: string;

  @doc("The IP tag value for egress.")
  ipTagValue?: string;

  @doc("The IP capacity for egress.")
  ipCapacity?: string;

  @doc("The IP version (IPv4 or IPv6). Defaults to IPv4.")
  ipVersion?: IpVersion;
}

@doc("Instance-level public IP configuration.")
model InstanceLevelPublicIpConfiguration {
  @doc("The prefix length for the public IP.")
  prefixLength?: int32;

  @doc("The IP tag type.")
  ipTagType?: string;

  @doc("The IP tag value.")
  ipTagValue?: string;

  @doc("The IP version (IPv4 or IPv6). Defaults to IPv4.")
  ipVersion?: IpVersion;
}
