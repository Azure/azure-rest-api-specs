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
/**
 * Billing Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "BillingManagementClient",
})
@versioned(Versions)
namespace Microsoft.Billing;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-10-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_10_01: "2021-10-01",
}
