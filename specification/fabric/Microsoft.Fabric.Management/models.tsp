import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Fabric;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Microsoft Fabric capacity properties.")
model FabricCapacityProperties {
  @doc("The current deployment state of Microsoft Fabric resource. The provisioningState is to indicate states for resource provisioning.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The current state of Microsoft Fabric resource. The state is to indicate more states outside of resource provisioning.")
  @visibility(Lifecycle.Read)
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
model RpSkuEnumerationForNewResourceResult {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @doc("The collection of available SKUs for new resources")
  @identifiers(#[])
  @pageItems
  value: RpSkuDetailsForNewResource[];

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
  locations: Azure.Core.azureLocation[];
}

@doc("An object that represents enumerating SKUs for existing resources")
model RpSkuEnumerationForExistingResourceResult {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @doc("The SKU details")
  @pageItems
  @identifiers(#[])
  value: RpSkuDetailsForExistingResource[];

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

@added(Versions.v2025_01_15_preview)
@doc("Describes Resource Quota")
model Quota {
  @doc("The name of the quota.")
  @visibility(Lifecycle.Read)
  name?: QuotaName;

  @doc("The unit of usage measurement.")
  unit: string;

  @doc("The current usage of the resource.")
  currentValue: int64;

  @doc("The maximum permitted usage of the resource.")
  limit: int64;
}

@@identifiers(PagedQuota.value, #[]);
@added(Versions.v2025_01_15_preview)
model PagedQuota is Page<Quota>;

@added(Versions.v2025_01_15_preview)
@doc("The Quota Names")
model QuotaName {
  @doc("The name of the resource.")
  value?: string;

  @doc("The localized name of the resource.")
  localizedValue?: string;
}
