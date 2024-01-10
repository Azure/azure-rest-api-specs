import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.BillingBenefits;
@doc("Savings plan order alias")
@tenantResource
model SavingsPlanOrderAliasModel
  is ProxyResource<SavingsPlanOrderAliasProperties> {
  @doc("Name of the savings plan order alias")
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @key("savingsPlanOrderAliasName")
  @segment("savingsPlanOrderAliases")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
@projectedName("client", "SavingsPlanOrderAlias")
interface SavingsPlanOrderAliasModels_SavingsPlanOrderAlias {
  @doc("Get a savings plan.")
  get is ArmResourceRead<SavingsPlanOrderAliasModel>;

  @doc("Create a savings plan. Learn more about permissions needed at https://go.microsoft.com/fwlink/?linkid=2215851")
  create is ArmResourceCreateOrUpdateAsync<SavingsPlanOrderAliasModel>;
}
