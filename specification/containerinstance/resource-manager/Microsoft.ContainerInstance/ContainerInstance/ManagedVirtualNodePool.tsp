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
scalar SandboxGroupResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerInstance/sandboxGroups",
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
  provisioningState?: ResourceProvisioningState;

  /**
   * The ARM resource ID of the backing AKS managed cluster. Set at create time and immutable thereafter.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  aksClusterResourceId: AksClusterResourceId;

  /**
   * The ARM resource ID of the user-assigned managed identity used by the node pool. Set at create time and immutable thereafter.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedIdentityResourceId: ManagedIdentityResourceId;

  /**
   * The ARM resource ID of the sandbox group associated with the node pool. Set at create time and immutable thereafter.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sandboxGroupResourceId: SandboxGroupResourceId;

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

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface ManagedVirtualNodePools {
  /**
   * Get the properties of the specified managed virtual node pool.
   */
  get is ArmResourceRead<ManagedVirtualNodePool, Error = CloudError>;

  /**
   * Create or update a managed virtual node pool.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedVirtualNodePool,
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

@@doc(ManagedVirtualNodePool.name, "The name of the managed virtual node pool.");
@@doc(ManagedVirtualNodePool.properties,
  "The properties of the managed virtual node pool."
);
@@doc(ManagedVirtualNodePools.createOrUpdate::parameters.resource,
  "The managed virtual node pool to create or update."
);
