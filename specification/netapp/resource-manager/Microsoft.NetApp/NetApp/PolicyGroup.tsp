import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Rest;
using Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Versioning;

namespace Microsoft.NetApp;

/**
 * Policy Group resource
 * A PolicyGroup is a collection of policies that are deployed as cohesive unit for a solution.
 * It allows for better organization and management of policies by grouping them together.
 * This resource is used to manage the lifecycle of PolicyGroups, including creating, updating, and deleting them, as well as listing them by subscription or resource group.
 */
@added(Versions.v2026_08_15_preview)
model PolicyGroup
  is Azure.ResourceManager.TrackedResource<PolicyGroupProperties> {
  ...ResourceNameParameter<
    Resource = PolicyGroup,
    KeyName = "policyGroupName",
    SegmentName = "policyGroups",
    NamePattern = "^[a-zA-Z0-9-]{1,63}"
  >;
}

/**
 * Policy Group properties
 */
@added(Versions.v2026_08_15_preview)
model PolicyGroupProperties {
  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetAppProvisioningState;
}

@added(Versions.v2026_08_15_preview)
@armResourceOperations
interface PolicyGroups {
  /**
   * Get the specified PolicyGroup
   */
  get is ArmResourceRead<PolicyGroup>;

  /**
   * Create the specified PolicyGroup
   */
  create is ArmResourceCreateOrReplaceAsync<PolicyGroup>;

  /**
   * Patch the specified PolicyGroup
   */
  update is ArmCustomPatchAsync<
    PolicyGroup,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      PolicyGroup,
      PolicyGroupProperties
    >,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PolicyGroup> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the specified PolicyGroup
   */
  delete is ArmResourceDeleteWithoutOkAsync<PolicyGroup>;

  /**
   * List Policy Groups by Resource Group
   */
  listByResourceGroup is ArmResourceListByParent<PolicyGroup>;

  /**
   * List Policy Groups by Subscription
   */
  listBySubscription is ArmListBySubscription<PolicyGroup>;
}
