import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingSubscription.tsp";
import "./BillingSubscriptionAlias.tsp";
import "./PaymentMethod.tsp";
import "./PaymentMethod.tsp";
import "./PaymentMethodLink.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "BillingManagementClient",
})
@versioned(Versions)
@doc("Billing Client")
namespace Microsoft.Billing;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2021-10-01 API version.")
  v2021_10_01: "2021-10-01",
}
