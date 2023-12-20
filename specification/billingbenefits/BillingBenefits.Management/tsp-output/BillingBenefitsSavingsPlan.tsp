import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BillingBenefitsSavingsPlanOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.BillingBenefits;
@doc("Savings plan")
@parentResource(BillingBenefitsSavingsPlanOrder)
model BillingBenefitsSavingsPlan is ProxyResource<SavingsPlanModelProperties> {
  @doc("ID of the savings plan")
  @path
  @key("savingsPlanId")
  @segment("savingsPlans")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface BillingBenefitsSavingsPlans {
  @doc("Get savings plan.")
  get is ArmResourceRead<
    BillingBenefitsSavingsPlan,
    {
      ...BaseParameters<BillingBenefitsSavingsPlan>;

      @doc("May be used to expand the detail information of some properties.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Update savings plan.")
  update is ArmResourcePatchSync<
    BillingBenefitsSavingsPlan,
    SavingsPlanModelProperties
  >;
  @doc("List savings plans in an order.")
  list is ArmResourceListByParent<BillingBenefitsSavingsPlan>;
  @doc("List savings plans.")
  listAll is ArmListBySubscription<BillingBenefitsSavingsPlan>;
  @doc("Validate savings plan patch.")
  validateUpdate is ArmResourceActionSync<
    BillingBenefitsSavingsPlan,
    SavingsPlanUpdateValidateRequest,
    SavingsPlanValidateResponse
  >;
}
