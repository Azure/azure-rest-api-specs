import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SoftwareSupplyChain;

/** Insight resource */
model Insight is TrackedResource<InsightProperties> {
  ...ResourceNameParameter<Insight>;
}

/** The properties of Insight resource */
model InsightProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Insights {
  get is ArmResourceRead<Insight>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Insight>;
  update is ArmTagsPatchAsync<Insight>;
  delete is ArmResourceDeleteSync<Insight>;
  listByResourceGroup is ArmResourceListByParent<Insight>;
  listBySubscription is ArmListBySubscription<Insight>;
}
