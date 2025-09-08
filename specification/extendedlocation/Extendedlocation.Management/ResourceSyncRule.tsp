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
@parentResource(CustomLocation)
model ResourceSyncRule
  is Azure.ResourceManager.TrackedResource<ResourceSyncRuleProperties> {
  ...ResourceNameParameter<
    Resource = ResourceSyncRule,
    KeyName = "childResourceName",
    SegmentName = "resourceSyncRules",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface ResourceSyncRules {
  /**
   * Gets the details of the resourceSyncRule with a specified resource group, subscription id Custom Location resource name and Resource Sync Rule name.
   */
  get is ArmResourceRead<ResourceSyncRule>;

  /**
   * Creates or updates a Resource Sync Rule in the parent Custom Location, Subscription Id and Resource Group
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ResourceSyncRule>;

  /**
   * Updates a Resource Sync Rule with the specified Resource Sync Rule name in the specified Resource Group, Subscription and Custom Location name.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ResourceSyncRule,
    PatchModel = PatchableResourceSyncRule,
    Response = ArmResponse<ResourceSyncRule>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the Resource Sync Rule with the specified Resource Sync Rule Name, Custom Location Resource Name, Resource Group, and Subscription Id.
   */
  delete is ArmResourceDeleteSync<ResourceSyncRule>;

  /**
   * Gets a list of Resource Sync Rules in the specified subscription. The operation returns properties of each Resource Sync Rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceSyncRules_ListByCustomLocationID")
  listByCustomLocationID is ArmResourceListByParent<ResourceSyncRule>;
}

@@maxLength(ResourceSyncRule.name, 63);
@@minLength(ResourceSyncRule.name, 1);
@@doc(ResourceSyncRule.name, "Resource Sync Rule name.");
@@doc(ResourceSyncRule.properties,
  "The set of properties specific to a Resource Sync Rule"
);
@@doc(ResourceSyncRules.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a Resource Sync Rule."
);
@@doc(ResourceSyncRules.update::parameters.properties,
  "The updatable fields of an existing Resource Sync Rule."
);
@@summary(ResourceSyncRules.listByCustomLocationID,
  "Lists all Resource Sync Rules in a Custom Location."
);
@@summary(ResourceSyncRules.get, "Gets a Resource Sync Rule.");
@@summary(ResourceSyncRules.createOrUpdate,
  "Creates or updates a Resource Sync Rule."
);
@@summary(ResourceSyncRules.update, "Updates a Resource Sync Rule.");
@@summary(ResourceSyncRules.delete, "Deletes a Resource Sync Rule.");
