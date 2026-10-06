import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// AgentFabricMembership resource and operations
// =============================================================================

/**
 * The AgentFabric membership of a managed cluster. A cluster may belong to at most one AgentFabric, so this resource always has the name 'default'. See https://aka.ms/aks/agentfabric-membership.
 */
@parentResource(ManagedCluster)
@added(Versions.v2026_08_02_preview)
model AgentFabricMembership
  is Azure.ResourceManager.ProxyResource<AgentFabricMembershipProperties> {
  ...ResourceNameParameter<
    Resource = AgentFabricMembership,
    KeyName = "agentFabricMembershipName",
    SegmentName = "agentFabricMemberships",
    NamePattern = "^default$"
  >;

  /**
   * Resource ID of the AgentFabric that this cluster is a member of. The AgentFabric must be in the same tenant and subscription as the managed cluster. As the ARM envelope property, it also stops a complete mode deployment from deleting the membership and silently detaching the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This field is allowed at the top-level as per the ARM resource specification."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkSecurity/agentFabrics";
    }
  ]>;
}

@armResourceOperations
@added(Versions.v2026_08_02_preview)
interface AgentFabricMemberships {
  /**
   * Gets the AgentFabric membership of a managed cluster.
   */
  get is ArmResourceRead<AgentFabricMembership>;

  /**
   * Creates or updates the AgentFabric membership of a managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentFabricMembership>;

  /**
   * Deletes the AgentFabric membership of a managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentFabricMembership,
    LroHeaders = ArmAsyncOperationHeaderWithLocation &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the AgentFabric memberships of a managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<
    AgentFabricMembership,
    Response = ArmResponse<AgentFabricMembershipsListResult>
  >;
}

/**
 * The current provisioning state of the AgentFabric membership.
 */
@Azure.Core.lroStatus
@added(Versions.v2026_08_02_preview)
union AgentFabricMembershipProvisioningState {
  string,

  /**
   * The provisioning of the AgentFabric membership was canceled.
   */
  Canceled: "Canceled",

  /**
   * The AgentFabric membership is being created.
   */
  Creating: "Creating",

  /**
   * The AgentFabric membership is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The provisioning of the AgentFabric membership failed.
   */
  Failed: "Failed",

  /**
   * The AgentFabric membership was provisioned successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The AgentFabric membership is being updated.
   */
  Updating: "Updating",
}

/**
 * The SKU of the AgentFabric membership. The SKU determines which AgentFabric components are deployed to the cluster.
 */
@added(Versions.v2026_08_02_preview)
union AgentFabricMembershipSkuName {
  string,

  /**
   * The Standard SKU.
   */
  Standard: "Standard",

  /**
   * The Premium SKU.
   */
  Premium: "Premium",
}

/**
 * Properties of the AgentFabric membership of a managed cluster.
 */
@added(Versions.v2026_08_02_preview)
model AgentFabricMembershipProperties {
  /**
   * The current provisioning state of the AgentFabric membership.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentFabricMembershipProvisioningState;

  /**
   * The SKU of the AgentFabric membership. Determines which AgentFabric components are deployed to the cluster.
   */
  sku: AgentFabricMembershipSkuName;
}

/**
 * The result of a request to list the AgentFabric memberships of a managed cluster.
 */
@added(Versions.v2026_08_02_preview)
model AgentFabricMembershipsListResult {
  /**
   * The list of AgentFabric memberships.
   */
  @pageItems
  value: AgentFabricMembership[];

  @doc("The URL to get the next set of AgentFabric membership results.")
  @nextLink
  nextLink?: ResourceLocation<AgentFabricMembership>;
}
