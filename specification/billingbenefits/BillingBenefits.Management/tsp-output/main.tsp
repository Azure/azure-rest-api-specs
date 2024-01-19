import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./SavingsPlanOrderAliasModel.tsp";
import "./SavingsPlanOrderModel.tsp";
import "./SavingsPlanModel.tsp";
import "./ReservationOrderAliasResponse.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Billing benefits RP",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Azure Benefits RP let users create and manage benefits like savings plan.")
namespace Microsoft.BillingBenefits;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-11-01 API version.")
  v2022_11_01: "2022-11-01",
}
