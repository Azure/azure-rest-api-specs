import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ContainerInstance;

/**
 * The provisioning state of a ManagedVirtualNodePool resource.
 */
@added(Versions.v2026_09_01_preview)
union ManagedVirtualNodePoolProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource provisioning request was accepted but not yet started.
   */
  Accepted: "Accepted",
}

@added(Versions.v2026_09_01_preview)
scalar AksClusterResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters",
    }
  ]>;

@added(Versions.v2026_09_01_preview)
scalar ManagedIdentityResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

@added(Versions.v2026_09_01_preview)
scalar AiAgentGroupResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerInstance/aiAgentsGroups",
    }
  ]>;

@added(Versions.v2026_09_01_preview)
scalar ContainerGroupResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerInstance/containerGroups",
    }
  ]>;

@added(Versions.v2026_09_01_preview)
scalar SubnetResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets",
    }
  ]>;

/**
 * Properties of a managed virtual node pool.
 */
@added(Versions.v2026_09_01_preview)
model ManagedVirtualNodePoolProperties {
  /**
   * The status of the last provisioning operation on the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedVirtualNodePoolProvisioningState;

  /**
   * The Azure resource ID of the backing AKS managed cluster. Set at create time and immutable thereafter.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  aksClusterResourceId: AksClusterResourceId;

  /**
   * The Azure resource ID of the user-assigned managed identity used by the node pool. Set at create time and immutable thereafter.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedIdentityResourceId: ManagedIdentityResourceId;

  /**
   * The Azure resource ID of the AI agents group associated with the node pool. Set at create time and immutable thereafter.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  aiAgentGroupResourceId: AiAgentGroupResourceId;

  /**
   * The Azure resource ID of the subnet used by container groups in the node pool.
   */
  @visibility(Lifecycle.Read)
  subnetResourceId?: SubnetResourceId;

  /**
   * Minimum number of nodes maintained by the pool.
   */
  @minValue(0)
  minNodes?: int32;

  /**
   * Maximum number of nodes the pool can scale to.
   */
  @minValue(1)
  maxNodes?: int32;

  /**
   * The desired number of container groups for the node pool.
   */
  @visibility(Lifecycle.Read)
  targetCount?: int32;

  /**
   * The number of container groups that are ready in the node pool.
   */
  @visibility(Lifecycle.Read)
  readyCount?: int32;

  /**
   * The container groups associated with the node pool.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  containerGroups?: ManagedVirtualNodePoolContainerGroup[];
}

/**
 * A container group associated with a managed virtual node pool.
 */
@added(Versions.v2026_09_01_preview)
model ManagedVirtualNodePoolContainerGroup {
  /**
   * The Azure resource ID of the container group.
   */
  @visibility(Lifecycle.Read)
  resourceId?: ContainerGroupResourceId;

  /**
   * The type of the container group.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The state of the container group.
   */
  @visibility(Lifecycle.Read)
  state?: string;
}

/**
 * A managed virtual node pool resource.
 */
@added(Versions.v2026_09_01_preview)
model ManagedVirtualNodePool
  is Azure.ResourceManager.TrackedResource<ManagedVirtualNodePoolProperties> {
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The name of the managed virtual node pool.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @key("managedVirtualNodePoolName")
  @segment("managedVirtualNodePools")
  @path
  name: string;
}

/**
 * Updatable resource-specific properties for `ManagedVirtualNodePool` PATCH.
 */
@added(Versions.v2026_09_01_preview)
model ManagedVirtualNodePoolPatchProperties {
  /**
   * Minimum number of nodes maintained by the pool.
   */
  @minValue(0)
  minNodes?: int32;

  /**
   * Maximum number of nodes the pool can scale to.
   */
  @minValue(1)
  maxNodes?: int32;
}

/**
 * The type used for updating a `ManagedVirtualNodePool` resource.
 */
@added(Versions.v2026_09_01_preview)
model ManagedVirtualNodePoolUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags is an acceptable use of Record for PATCH update envelopes."
  tags?: Record<string>;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Resource-specific properties that can be updated via PATCH.
   */
  properties?: ManagedVirtualNodePoolPatchProperties;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface ManagedVirtualNodePools {
  /**
   * Get the properties of the specified managed virtual node pool.
   */
  get is ArmResourceRead<ManagedVirtualNodePool, Error = CloudError>;

  /**
   * List managed virtual node pools by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ManagedVirtualNodePool,
    Error = CloudError
  >;

  /**
   * List managed virtual node pools by subscription.
   */
  listBySubscription is ArmListBySubscription<
    ManagedVirtualNodePool,
    Error = CloudError
  >;

  /**
   * Create or update a managed virtual node pool.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedVirtualNodePool,
    Error = CloudError
  >;

  /**
   * Update a managed virtual node pool. Only tags and a limited set of properties can be updated.
   */
  update is ArmCustomPatchAsync<
    ManagedVirtualNodePool,
    PatchModel = ManagedVirtualNodePoolUpdate,
    Error = CloudError
  >;

  /**
   * Delete a managed virtual node pool.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedVirtualNodePool,
    Error = CloudError
  >;
}

@@doc(
  ManagedVirtualNodePool.name,
  "The name of the managed virtual node pool."
);
@@doc(
  ManagedVirtualNodePool.properties,
  "The properties of the managed virtual node pool."
);
@@doc(
  ManagedVirtualNodePools.createOrUpdate::parameters.resource,
  "The managed virtual node pool to create or update."
);
@@doc(
  ManagedVirtualNodePools.update::parameters.properties,
  "The managed virtual node pool patch object."
);
