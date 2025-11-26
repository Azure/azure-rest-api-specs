import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Savings plan order
 */
@tenantResource
model SavingsPlanOrderModel
  is Azure.ResourceManager.ProxyResource<SavingsPlanOrderModelProperties> {
  ...ResourceNameParameter<
    Resource = SavingsPlanOrderModel,
    KeyName = "savingsPlanOrderId",
    SegmentName = "savingsPlanOrders",
    NamePattern = ""
  >;

  /**
   * Savings plan SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: ResourceSku;
}

@armResourceOperations
interface SavingsPlanOrderModels {
  /**
   * Get a savings plan order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<
    SavingsPlanOrderModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * May be used to expand the detail information of some properties.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * List all Savings plan orders.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    SavingsPlanOrderModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<SavingsPlanOrderModelList>
  >;

  /**
   * Elevate as owner on savings plan order based on billing permissions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  elevate is ArmResourceActionSync<
    SavingsPlanOrderModel,
    void,
    ArmResponse<RoleAssignmentEntity>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(SavingsPlanOrderModel.name, "Order ID of the savings plan");
@@doc(SavingsPlanOrderModel.properties, "Savings plan order properties");
