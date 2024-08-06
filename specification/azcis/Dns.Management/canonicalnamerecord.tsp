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
model CanonicalNameRecordResourceProperties {
  @doc("Gets or sets the dns name")
  dnsName: string;

  @doc("Gets or sets the canonical name")
  canonicalName: string;

  @doc("Gets or sets the ttl")
  ttl: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: CanonicalNameRecordProvisioningState;
}

@doc("CanonicalNameRecord Resource")
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
union CanonicalNameRecordProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface CanonicalNameRecord {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CanonicalNameRecordResource>;
  listBySubscription is ArmListBySubscription<CanonicalNameRecordResource>;
  listByResourceGroup is ArmResourceListByParent<CanonicalNameRecordResource>;
  get is ArmResourceRead<CanonicalNameRecordResource>;
}
