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
@doc("Savings plan order")
@tenantResource
model SavingsPlanOrderModel is ProxyResource<SavingsPlanOrderModelProperties> {
  @doc("Order ID of the savings plan")
  @path
  @key("savingsPlanOrderId")
  @segment("savingsPlanOrders")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SavingsPlanOrderModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a savings plan order.")
  @operationId("SavingsPlanOrder_Get")
  get is ArmResourceRead<
    SavingsPlanOrderModel,
    {
      ...BaseParameters<SavingsPlanOrderModel>;

      @doc("May be used to expand the detail information of some properties.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all Savings plan orders.")
  @operationId("SavingsPlanOrder_List")
  list is ArmResourceListByParent<SavingsPlanOrderModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Elevate as owner on savings plan order based on billing permissions.")
  @operationId("SavingsPlanOrder_Elevate")
  elevate is ArmResourceActionSync<
    SavingsPlanOrderModel,
    void,
    RoleAssignmentEntity
  >;
}
