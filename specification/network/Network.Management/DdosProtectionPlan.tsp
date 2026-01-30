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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model DdosProtectionPlan extends ResourceWithReadOnlyID {
  properties?: DdosProtectionPlanPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("ddosProtectionPlanName")
  @segment("ddosProtectionPlans")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface DdosProtectionPlans {
  /**
   * Gets information about the specified DDoS protection plan.
   */
  get is ArmResourceRead<DdosProtectionPlan, Error = CloudError>;

  /**
   * Creates or updates a DDoS protection plan.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DdosProtectionPlan,
    Error = CloudError
  >;

  /**
   * Update a DDoS protection plan tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    DdosProtectionPlan,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified DDoS protection plan.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DdosProtectionPlan,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the DDoS protection plans in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    DdosProtectionPlan,
    Error = CloudError
  >;

  /**
   * Gets all DDoS protection plans in a subscription.
   */
  list is ArmListBySubscription<DdosProtectionPlan, Error = CloudError>;
}

@@doc(DdosProtectionPlan.name, "The name of the DDoS protection plan.");
@@doc(DdosProtectionPlan.properties, "Properties of the DDoS protection plan.");
@@doc(DdosProtectionPlans.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update operation."
);
@@doc(DdosProtectionPlans.updateTags::parameters.properties,
  "Parameters supplied to the update DDoS protection plan resource tags."
);
