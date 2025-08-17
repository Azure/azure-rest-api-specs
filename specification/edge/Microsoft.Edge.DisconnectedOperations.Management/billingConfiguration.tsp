import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./disconnectedOperations.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

@doc("Billing configuration resource.")
@parentResource(DisconnectedOperation)
@added(Microsoft.Edge.Versions.v2025_08_01)
model BillingConfiguration is ProxyResource<BillingConfigurationProperties> {
  ...ResourceNameParameter<BillingConfiguration>;
}

@armResourceOperations
@added(Microsoft.Edge.Versions.v2025_08_01)
interface BillingConfigurationOperations {
  @doc("List by parent")
  listByParent is ArmResourceListByParent<BillingConfiguration>;

  @doc("Get the billing configuration resource")
  get is ArmResourceRead<BillingConfiguration>;

  @doc("Create or update billing configuration")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BillingConfiguration>;

  @doc("Delete billing configuration")
  delete is ArmResourceDeleteWithoutOkAsync<BillingConfiguration>;
}
