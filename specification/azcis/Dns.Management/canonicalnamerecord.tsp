import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("CanonicalNameRecord properties")
@added(Versions.v2024_06_24_preview)
model CanonicalNameRecordResourceProperties {
  @doc("Gets or sets the dns name")
  dnsName: string;

  @doc("Gets or sets the canonical name")
  canonicalName: string;

  @doc("Gets or sets the ttl")
  ttl: string;

  @doc("Arm location")
  armLocation?: string; 

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: CanonicalNameRecordProvisioningState;
}

@doc("CanonicalNameRecord Resource")
@added(Versions.v2024_06_24_preview)
model CanonicalNameRecordResource
  is ProxyResource<CanonicalNameRecordResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("canonicalNameRecords") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
@added(Versions.v2024_06_24_preview)
union CanonicalNameRecordProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
@added(Versions.v2024_06_24_preview)
interface CanonicalNameRecord {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CanonicalNameRecordResource>;
  listBySubscription is ArmListBySubscription<CanonicalNameRecordResource>;
  listByResourceGroup is ArmResourceListByParent<CanonicalNameRecordResource>;
  get is ArmResourceRead<CanonicalNameRecordResource>;
}
