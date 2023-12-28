import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SavingsPlanOrderModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.BillingBenefits;
@doc("Savings plan")
@parentResource(SavingsPlanOrderModel)
model SavingsPlanModel is ProxyResource<SavingsPlanModelProperties> {
  @doc("ID of the savings plan")
  @key("savingsPlanId")
  @segment("savingsPlans")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SavingsPlan {
  @doc("Get savings plan.")
  get is ArmResourceRead<
    SavingsPlanModel,
    {
      ...BaseParameters<SavingsPlanModel>;

      @doc("May be used to expand the detail information of some properties.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Update savings plan.")
  update is ArmCustomPatchSync<SavingsPlanModel, SavingsPlanUpdateRequest>;
  @doc("List savings plans in an order.")
  list is ArmResourceListByParent<SavingsPlanModel>;
  @doc("List savings plans.")
  listAll is ArmListBySubscription<SavingsPlanModel>;
  @doc("Validate savings plan patch.")
  validateUpdate is ArmResourceActionSync<
    SavingsPlanModel,
    SavingsPlanUpdateValidateRequest,
    SavingsPlanValidateResponse
  >;
}
