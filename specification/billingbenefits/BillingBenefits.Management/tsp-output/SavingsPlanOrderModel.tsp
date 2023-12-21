import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.BillingBenefits;
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
interface SavingsPlanOrder {
  @doc("Get a savings plan order.")
  get is ArmResourceRead<
    SavingsPlanOrderModel,
    {
      ...BaseParameters<SavingsPlanOrderModel>;

      @doc("May be used to expand the detail information of some properties.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("List all Savings plan orders.")
  list is ArmResourceListByParent<SavingsPlanOrderModel>;
  @doc("Elevate as owner on savings plan order based on billing permissions.")
  elevate is ArmResourceActionSync<
    SavingsPlanOrderModel,
    void,
    RoleAssignmentEntity
  >;
}
