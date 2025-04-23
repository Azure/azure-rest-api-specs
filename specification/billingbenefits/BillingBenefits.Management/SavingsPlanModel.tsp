import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SavingsPlanOrderModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Savings plan
 */
@parentResource(SavingsPlanOrderModel)
model SavingsPlanModel
  is Azure.ResourceManager.ProxyResource<SavingsPlanModelProperties> {
  ...ResourceNameParameter<
    Resource = SavingsPlanModel,
    KeyName = "savingsPlanId",
    SegmentName = "savingsPlans",
    NamePattern = ""
  >;

  /**
   * Savings plan SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: ResourceSku;
}

@armResourceOperations
interface SavingsPlanModels {
  /**
   * Get savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SavingsPlan_Get")
  get is ArmResourceRead<
    SavingsPlanModel,
    Parameters = {
      /**
       * May be used to expand the detail information of some properties.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Update savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("SavingsPlan_Update")
  update is ArmCustomPatchAsync<
    SavingsPlanModel,
    PatchModel = SavingsPlanUpdateRequest,
    Response = ArmResponse<SavingsPlanModel> | ArmAcceptedLroResponse | ArmResourceNotFoundResponse
  >;

  /**
   * List savings plans in an order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SavingsPlan_List")
  list is ArmResourceListByParent<
    SavingsPlanModel,
    Response = ArmResponse<SavingsPlanModelList>
  >;

  /**
   * Validate savings plan patch.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("validate")
  @operationId("SavingsPlan_ValidateUpdate")
  validateUpdate is ArmResourceActionSync<
    SavingsPlanModel,
    SavingsPlanUpdateValidateRequest,
    ArmResponse<SavingsPlanValidateResponse>
  >;
}

@@doc(SavingsPlanModel.name, "ID of the savings plan");
@@doc(SavingsPlanModel.properties, "Savings plan properties");
@@doc(SavingsPlanModels.update::parameters.properties,
  "Request body for patching a savings plan order alias"
);
@@doc(SavingsPlanModels.validateUpdate::parameters.body,
  "Request body for validating a savings plan patch request"
);
