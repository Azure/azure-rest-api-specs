import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

namespace Microsoft.Fabric;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Microsoft Fabric capacity properties.")
model FabricCapacityProperties {
  @doc("The current deployment state of Microsoft Fabric resource. The provisioningState is to indicate states for resource provisioning.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The current state of Microsoft Fabric resource. The state is to indicate more states outside of resource provisioning.")
  @visibility("read")
  state?: ResourceState;

  @doc("The capacity administration")
  administration: CapacityAdministration;
}

@doc("Represents the SKU name and Azure pricing tier for Microsoft Fabric capacity resource.")
model RpSku {
  @doc("The name of the SKU level.")
  name: string;

  @doc("The name of the Azure pricing tier to which the SKU applies.")
  tier: RpSkuTier;
}

@doc("The name of the Azure pricing tier to which the SKU applies.")
union RpSkuTier {
  string,

  @doc("Fabric tier")
  fabric: "Fabric",
}

@doc("The administration properties of the Fabric capacity resource")
model CapacityAdministration {
  @doc("An array of administrator user identities.")
  members: Array<string>;
}

@doc("The provisioning state of the Fabric capacity resource.")
union ProvisioningState {
  ResourceProvisioningState,

  /** Resource is deleting */
  Deleting: "Deleting",

  /** Resource is provisioning */
  Provisioning: "Provisioning",

  /** Resource is updating */
  Updating: "Updating",

  string,
}

@doc("The state of the Fabric capacity resource.")
union ResourceState {
  /** Resource is active */
  Active: "Active",

  /** Resource is provisioning */
  Provisioning: "Provisioning",

  /** Resource is failed */
  Failed: "Failed",

  /** Resource is updating */
  Updating: "Updating",

  /** Resource is deleting */
  Deleting: "Deleting",

  /** Resource is suspending */
  Suspending: "Suspending",

  /** Resource is suspended */
  Suspended: "Suspended",

  /** Resource is pausing */
  Pausing: "Pausing",

  /** Resource is paused */
  Paused: "Paused",

  /** Resource is resuming */
  Resuming: "Resuming",

  /** Resource is scaling */
  Scaling: "Scaling",

  /** Resource is preparing */
  Preparing: "Preparing",

  string,
}

@doc("An object that represents enumerating SKUs for new resources.")
@pagedResult
model RpSkuEnumerationForNewResourceResult {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @doc("The collection of available SKUs for new resources")
  value: Array<RpSkuDetailsForNewResource>;

  @doc("Url for the next page.  Null if no more pages available")
  @nextLink
  nextLink?: string;
}

@doc("The SKU details")
model RpSkuDetailsForNewResource {
  @doc("The resource type")
  resourceType: string;

  ...RpSkuProperties;
}

@doc("The SKU properties")
model RpSkuProperties {
  @doc("The SKU's name")
  name: string;

  @doc("The list of available locations for the SKU")
  locations: Array<Azure.Core.azureLocation>;
}

@doc("An object that represents enumerating SKUs for existing resources")
@pagedResult
model RpSkuEnumerationForExistingResourceResult {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @doc("The SKU details")
  value: Array<RpSkuDetailsForExistingResource>;

  @doc("Url for the next page.  Null if no more pages available")
  @nextLink
  nextLink?: string;
}

@doc("An object that represents SKU details for existing resources")
model RpSkuDetailsForExistingResource {
  @doc("The resource type")
  resourceType: string;

  @doc("The SKU details")
  sku: RpSku;
}

@doc("The name of the capacity.")
model CapacityNameParameter {
  @doc("The name of the capacity.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]*$")
  @TypeSpec.Rest.segment("capacities")
  @path
  capacityName: string;
}
