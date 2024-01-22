import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Savings plan order
 */
@tenantResource
model SavingsPlanOrderModel is ProxyResource<SavingsPlanOrderModelProperties> {
  /**
   * Order ID of the savings plan
   */
  @path
  @key("savingsPlanOrderId")
  @segment("savingsPlanOrders")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SavingsPlanOrderModels {
  /**
   * Get a savings plan order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlanOrder_Get")
  get is ArmResourceRead<
    SavingsPlanOrderModel,
    {
      ...BaseParameters<SavingsPlanOrderModel>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlanOrder_List")
  list is ArmResourceListByParent<SavingsPlanOrderModel>;

  /**
   * Elevate as owner on savings plan order based on billing permissions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlanOrder_Elevate")
  elevate is ArmResourceActionSync<
    SavingsPlanOrderModel,
    void,
    RoleAssignmentEntity
  >;
}
