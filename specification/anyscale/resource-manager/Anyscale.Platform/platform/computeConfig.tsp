import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./versions.tsp";
import "./cloud.tsp";

using Rest;
using Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Anyscale.Platform;

@added(Versions.v2026_02_01_preview)
@parentResource(Cloud)
@resource("computeConfigs")
model ComputeConfig is ProxyResource<ComputeConfigProperties> {
  /** The name of the compute config. */
  @pattern("^[a-zA-Z0-9_-]*$")
  @key("computeConfigName")
  @path
  @segment("computeConfigs")
  name: string;
}

/** Properties of the compute config. */
@added(Versions.v2026_02_01_preview)
model ComputeConfigProperties {
  /** Compute config specification. */
  spec: ComputeConfigSpec;

  /** The URL to the compute config overview page in the Anyscale console. */
  @visibility(Lifecycle.Read)
  url?: string;

  /** The current revision number. This is incremented when the compute config is updated. */
  @visibility(Lifecycle.Read)
  revision?: int32;

  /** The provisioning state of the compute config. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** An inline compute config spec or a predefined compute config which is used in the workload. */
@added(Versions.v2026_02_01_preview)
model ComputeConfigSpecOrReference {
  /** The inlined compute config spec. */
  spec?: ComputeConfigSpec;

  /** The reference to the resource name of existing predefined compute config. */
  computeConfigName?: string;
}

/** Compute config specifications. */
@added(Versions.v2026_02_01_preview)
model ComputeConfigSpec {
  /** A list of the compute config options. */
  @identifiers(#[])
  options?: ComputeConfigSpecOption[];
}

/** One compute config option. */
@added(Versions.v2026_02_01_preview)
model ComputeConfigSpecOption {
  /** The name of the corresponding cloud resource to use for this compute config under the Anyscale cloud to launch the cluster. If not specified, all cloud resources will be used. */
  cloudResourceNames?: string[];

  /** The node type to use for the head node. */
  headNode: NodeType;

  /** The node types to use for the worker nodes. */
  workerNodes?: WorkerNode[];

  /** The availability zones that sessions are allowed to be launched in, e.g. "eastus-1". If not specified or "any" is provided as the option, any AZ may be used. If "any" is provided, it must be the only item in the list. */
  zones?: string[];

  /** Advanced configurations for this deployment compute config to pass to the cloud provider when launching this instance. */
  advancedInstanceConfig?: string;

  /** A set of advanced cluster-level flags that can be used to configure a particular workload. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Intended to be a free form json"
  flags?: {};
}

/**
 * Logical resources for a node type used during Ray scheduling.
 */
@added(Versions.v2026_02_01_preview)
model LogicalResources {
  /** Number of CPUs in this node type. */
  cpu?: int64;

  /** Number of GPUs in this node type. */
  gpu?: int64;

  /** Amount of memory to allocate to the Python worker. */
  memory?: int64;

  /** The amount of memory in bytes allocated for the Ray object store on this node. */
  objectStoreMemory?: int64;

  /** Custom resources for this node to be used by Ray autoscaler. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Existing use case"
  customResources?: {};
}

/**
 * Physical resources for the underlying node type.
 */
@added(Versions.v2026_02_01_preview)
model PhysicalResources {
  /** Number of CPUs to allocate. */
  cpu?: int64;

  /** Number of GPUs to allocate. */
  gpu?: int64;

  /** Amount of memory in bytes to allocate. */
  memory?: int64;

  /** Number of TPUs to allocate. */
  tpu?: int64;

  /** Type of accelerator (e.g., 'T4', 'L4', 'H100'). */
  accelerator?: string;

  /** CPU architecture type. Valid values: 'x86_64' (default), 'arm64'. */
  cpuArchitecture?: string;
}

/** Configuration of a node group. */
@added(Versions.v2026_02_01_preview)
model NodeType {
  /** Unique name of this node group. */
  name: string;

  /** The cloud provider instance type to use for this node. Optional when using requiredResources. */
  instanceType?: string;

  /** Declaration of logical node resources for Ray. */
  resources?: LogicalResources;

  /** Required resources for compute node type which specifies the actual CPU, memory, and GPU resources that should be allocated for this node type. */
  requiredResources?: PhysicalResources;

  /** Labels to associate the node with for Ray scheduling purposes. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "A list of key value pairs"
  labels?: {};

  /** Required labels that must be present on the node for node (pod) scheduling purposes. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "A list of key value pairs"
  requiredLabels?: {};

  /** Advanced configurations for this compute node type to pass to the cloud provider when launching this instance. */
  advancedInstanceConfig?: string;

  /** A set of advanced node-level flags that can be used to configure a particular workload. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "A list of key value pairs"
  flags?: {};
}

/** Market type of instances to use (on-demand vs spot). */
@added(Versions.v2026_02_01_preview)
union MarketType {
  /** Use on-demand instances only. */
  ON_DEMAND: "ON_DEMAND",

  /** Use spot instances only. */
  SPOT: "SPOT",

  /** Prefer to use spot instances but fall back to on-demand if necessary. */
  PREFER_SPOT: "PREFER_SPOT",

  string,
}

/** Configuration for a worker node group. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@added(Versions.v2026_02_01_preview)
model WorkerNode extends NodeType {
  /** Minimum number of nodes of this type that will be kept running in the cluster. */
  minNodes?: int32;

  /** Maximum number of nodes of this type that can be running in the cluster. */
  maxNodes?: int32;

  /** Market type of the instances. */
  marketType?: MarketType = MarketType.ON_DEMAND;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface ComputeConfigs {
  get is ArmResourceRead<ComputeConfig>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ComputeConfig>;
  update is ArmCustomPatchSync<
    ComputeConfig,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ComputeConfig,
      ComputeConfigProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ComputeConfig>;
  listByResourceGroup is ArmResourceListByParent<ComputeConfig>;
  listBySubscription is ArmListBySubscription<ComputeConfig>;
}
