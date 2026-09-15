import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Spend plan resource definition.
 */
@added(Versions.v2026_07_01_preview)
model SpendPlan is Azure.ResourceManager.TrackedResource<SpendPlanProperties> {
  ...ResourceNameParameter<
    Resource = SpendPlan,
    KeyName = "spendPlanName",
    SegmentName = "spendPlans",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
  ...ResourceKindProperty<SpendPlanKind>;
}

@armResourceOperations
@added(Versions.v2026_07_01_preview)
interface SpendPlans {
  /**
   * Get a spend plan.
   */
  get is ArmResourceRead<SpendPlan>;

  /**
   * Create a spend plan.
   */
  create is ArmResourceCreateOrReplaceAsync<SpendPlan>;

  /**
   * Update a spend plan.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<SpendPlan, PatchModel = SpendPlanPatchRequest>;

  /**
   * Delete a spend plan.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SpendPlan>;

  /**
   * List spend plans under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    SpendPlan,
    Response = ArmResponse<SpendPlanList>
  >;

  /**
   * List spend plans under a subscription.
   */
  listBySubscription is ArmListBySubscription<
    SpendPlan,
    Response = ArmResponse<SpendPlanList>
  >;

  /**
   * Cancel a spend plan. This stops applying the benefit to the account but does not delete the spend plan resource.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  cancel is ArmResourceActionAsyncBase<
    SpendPlan,
    Request = void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SpendPlan>,
    Response =
      | ArmResponse<SpendPlan>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SpendPlan> &
          Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@doc(SpendPlan.name, "Name of the spend plan");
@@doc(SpendPlan.properties, "Spend plan properties");
@@visibility(SpendPlan.kind, Lifecycle.Read, Lifecycle.Create);
@@doc(SpendPlans.create::parameters.resource, "Spend plan create request");
@@doc(SpendPlans.update::parameters.properties, "Spend plan patch request");
