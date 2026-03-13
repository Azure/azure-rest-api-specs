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

namespace Microsoft.Billing;
/**
 * Savings plan
 */
@tenantResource
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
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Savings plan SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;
}

@armResourceOperations(#{ omitTags: true })
interface SavingsPlanModels {
  /**
   * Get savings plan by billing account.
   */
  @tag("Savings plan")
  getByBillingAccount is ArmResourceRead<
    SavingsPlanModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * May be used to expand the planInformation.
       */
      @query("expand")
      expand?: string;
    }
  >;

  /**
   * Update savings plan by billing account.
   */
  @tag("Savings plan")
  @patch(#{ implicitOptionality: false })
  updateByBillingAccount is ArmCustomPatchAsync<
    SavingsPlanModel,
    PatchModel = SavingsPlanUpdateRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SavingsPlanModel> &
      ArmLroLocationHeader<FinalResult = SavingsPlanModel> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List savings plans in an order by billing account.
   */
  @tag("Savings plan")
  listBySavingsPlanOrder is ArmResourceListByParent<
    SavingsPlanModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<SavingsPlanModelList>
  >;

  /**
   * Validate savings plan patch by billing account.
   */
  @tag("Savings plan")
  @action("validate")
  validateUpdateByBillingAccount is ArmResourceActionSync<
    SavingsPlanModel,
    SavingsPlanUpdateValidateRequest,
    ArmResponse<SavingsPlanValidateResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(SavingsPlanModel.name, "ID of the savings plan");
@@doc(SavingsPlanModel.properties, "Savings plan properties");
@@doc(SavingsPlanModels.updateByBillingAccount::parameters.properties,
  "Request body for patching a savings plan order alias"
);
@@doc(SavingsPlanModels.validateUpdateByBillingAccount::parameters.body,
  "Request body for patching a savings plan order alias"
);
