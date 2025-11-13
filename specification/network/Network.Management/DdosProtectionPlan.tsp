import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A DDoS protection plan in a resource group.
 */
model DdosProtectionPlan
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DdosProtectionPlanPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = DdosProtectionPlan,
    KeyName = "ddosProtectionPlanName",
    SegmentName = "ddosProtectionPlans",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface DdosProtectionPlans {
  /**
   * Gets information about the specified DDoS protection plan.
   */
  get is ArmResourceRead<DdosProtectionPlan>;

  /**
   * Creates or updates a DDoS protection plan.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DdosProtectionPlan>;

  /**
   * Update a DDoS protection plan tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<DdosProtectionPlan, PatchModel = TagsObject>;

  /**
   * Deletes the specified DDoS protection plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DdosProtectionPlan,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the DDoS protection plans in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<DdosProtectionPlan>;

  /**
   * Gets all DDoS protection plans in a subscription.
   */
  list is ArmListBySubscription<DdosProtectionPlan>;
}

@@doc(DdosProtectionPlan.name, "The name of the DDoS protection plan.");
@@doc(DdosProtectionPlan.properties, "Properties of the DDoS protection plan.");
@@doc(DdosProtectionPlans.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update operation."
);
@@doc(DdosProtectionPlans.updateTags::parameters.properties,
  "Parameters supplied to the update DDoS protection plan resource tags."
);
