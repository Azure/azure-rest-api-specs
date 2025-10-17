import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_09_01_preview)
@doc("billingContainer Model as Azure resource whose sole purpose is to keep track of billables resources under a subscription.")
@subscriptionResource
model BillingContainer is ProxyResource<BillingContainerProperties> {
  @doc("Name of the billing container.")
  @key("billingContainerName")
  @segment("billingContainers")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  // etag not included in ProxyResource
  // Suppress linter false positive for etag properties not allowed at top level of ProxyResource
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource ETag")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@added(Versions.v2024_09_01_preview)
@doc("Defines the billingContainer properties.")
model BillingContainerProperties {
  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_09_01_preview)
@armResourceOperations
interface BillingContainers {
  get is ArmResourceRead<BillingContainer>;
  listBySubscription is ArmListBySubscription<BillingContainer>;

  // PUT is not allowed for end users.
  // createOrReplace is ArmResourceCreateOrReplaceAsync<BillingContainer>;

  // PATCH is not allowed for end users. we don't have updatable property today.
  // update is ArmResourcePatchAsync<BillingContainer, BillingContainerProperties>;

  // DELETE is not allowed for end users.
  // delete is ArmResourceDeleteWithoutOkAsync<BillingContainer>;
}
