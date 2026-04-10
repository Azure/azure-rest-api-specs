import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CustomLocation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ExtendedLocation;
/**
 * Resource Sync Rules definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "Existing swagger uses camelCase"
@parentResource(customLocation)
model resourceSyncRule
  is Azure.ResourceManager.TrackedResource<resourceSyncRuleProperties> {
  ...ResourceNameParameter<
    Resource = resourceSyncRule,
    KeyName = "childResourceName",
    SegmentName = "resourceSyncRules",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ResourceSyncRules {
  /**
   * Gets the details of the resourceSyncRule with a specified resource group, subscription id Custom Location resource name and Resource Sync Rule name.
   */
  @summary("Gets a Resource Sync Rule.")
  @tag("resourceSyncRules")
  get is ArmResourceRead<resourceSyncRule>;

  /**
   * Creates or updates a Resource Sync Rule in the parent Custom Location, Subscription Id and Resource Group
   */
  @summary("Creates or updates a Resource Sync Rule.")
  @tag("resourceSyncRules")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<resourceSyncRule>;

  /**
   * Updates a Resource Sync Rule with the specified Resource Sync Rule name in the specified Resource Group, Subscription and Custom Location name.
   */
  @summary("Updates a Resource Sync Rule.")
  @tag("resourceSyncRules")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    resourceSyncRule,
    PatchModel = patchableResourceSyncRule,
    Response = ArmResponse<resourceSyncRule> &
      ArmAsyncOperationHeader<FinalResult = resourceSyncRule> &
      Azure.Core.Foundations.RetryAfterHeader,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = resourceSyncRule> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the Resource Sync Rule with the specified Resource Sync Rule Name, Custom Location Resource Name, Resource Group, and Subscription Id.
   */
  @summary("Deletes a Resource Sync Rule.")
  @tag("resourceSyncRules")
  delete is ArmResourceDeleteSync<resourceSyncRule>;

  /**
   * Gets a list of Resource Sync Rules in the specified subscription. The operation returns properties of each Resource Sync Rule
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @summary("Lists all Resource Sync Rules in a Custom Location.")
  @tag("resourceSyncRules")
  listByCustomLocationID is ArmResourceListByParent<
    resourceSyncRule,
    Response = ArmResponse<resourceSyncRuleListResult>
  >;
}

@@maxLength(resourceSyncRule.name, 63);
@@minLength(resourceSyncRule.name, 1);
@@doc(resourceSyncRule.name, "Resource Sync Rule name.");
@@doc(resourceSyncRule.properties,
  "The set of properties specific to a Resource Sync Rule"
);
@@doc(ResourceSyncRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a Resource Sync Rule."
);
@@doc(ResourceSyncRules.update::parameters.properties,
  "The updatable fields of an existing Resource Sync Rule."
);
