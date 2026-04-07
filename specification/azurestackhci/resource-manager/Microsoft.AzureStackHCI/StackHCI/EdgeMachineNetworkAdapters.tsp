import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.AzureStackHCI;

// ==================== Network Adapter Resource ====================

/**
 * Edge Machine Network Adapter Resource.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineNetworkAdapter
  is Azure.ResourceManager.ProxyResource<EdgeMachineNetworkAdapterProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineNetworkAdapter,
    KeyName = "networkAdapterName",
    SegmentName = "networkAdapters",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Edge Machine Network Adapters.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineNetworkAdapters {
  /** Get a specific network adapter on an Edge Machine. */
  get is ArmResourceRead<EdgeMachineNetworkAdapter>;

  /** List all network adapters on an Edge Machine. */
  list is ArmResourceListByParent<EdgeMachineNetworkAdapter>;
}

// ==================== Network Adapter Jobs Resource ====================

/**
 * Job for an Edge Machine Network Adapter.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachineNetworkAdapter)
model EdgeMachineNetworkAdapterJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineNetworkAdapterJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineNetworkAdapterJob,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Edge Machine Network Adapter Jobs.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineNetworkAdapterJobs {
  /** Get a specific network adapter job. */
  get is ArmResourceRead<EdgeMachineNetworkAdapterJob>;

  /** List all jobs for a network adapter. */
  list is ArmResourceListByParent<EdgeMachineNetworkAdapterJob>;

  /** Create or update a network adapter job. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineNetworkAdapterJob>;

  /** Delete a network adapter job. */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineNetworkAdapterJob>;
}
